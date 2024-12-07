import os
import sys
import logging

from datetime import datetime, timedelta

lib_folder_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "..")
sys.path.append(os.path.abspath(lib_folder_path))

from airflow.models import DAG
from airflow.models import Variable
from airflow.operators.python_operator import PythonOperator
from airflow.providers.databricks.operators.databricks import DatabricksRunNowOperator

dag_name = os.path.basename(__file__).replace(".pyc", "").replace(".py", "")
config = Variable.get(f"{dag_name}_config", deserialize_json=True)

# DAG start time.
cron_start = datetime.strptime(config["cron_start"], "%Y-%m-%d %H:%M:00")
# DAG schedule interval.
cron_schedule = None
if (config["cron_schedule"] != "" and config["cron_schedule"] != "None"):
    cron_schedule = config["cron_schedule"]
# mailing list for notifications.
mailing_list = config["mailing_list"]
# Databricks connection ID.
databricks_conn_id = "databricks_default"

default_args = {
    "owner": "airflow",
    "email": mailing_list,
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 0,
    "retry_delay": timedelta(minutes=3),
    "start_date": cron_start,
    "execution_timeout": None,
    "schedule_interval": cron_schedule,
    "catchup": False,
    "tags": dag_name.split("_")
}

log = logging.getLogger(__name__)

def calculate_cutoff_time(**kwargs):
    current_utc_time = datetime.now(datetime.timezone.utc)
    target_etl_cutoff_time = (current_utc_time - timedelta(minutes=5)).strftime("%Y-%m-%d %H:%M:%S.%f")

    return target_etl_cutoff_time

with DAG(
    dag_name,
    default_args=default_args,
    start_date=default_args["start_date"],
    schedule_interval=default_args["schedule_interval"],
    catchup=False,
    tags=default_args["tags"]
) as dag:
    calculate_cutoff_time_task = PythonOperator(
        task_id="calculate_cutoff_time",
        python_callable=calculate_cutoff_time,
        provide_context=True
    )

    load_dim_date_task = DatabricksRunNowOperator(
        task_id="load_dim_date",
        databricks_conn_id=databricks_conn_id,
        job_name="load_dim_date"
    )