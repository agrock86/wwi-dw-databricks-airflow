# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

# MAGIC %run ./etl_utils

# COMMAND ----------

from pyspark.sql import functions as f
from delta.tables import DeltaTable

# COMMAND ----------


table_name = dbutils.widgets.get("table_name")

stg_table_name = f"stg_{table_name}"
fact_table_name = f"fct_{table_name}"
pk_column_name = f"wwi_stock_item_transaction_id"

# COMMAND ----------

# Drop columns not required for the merge operation.
stg_df = spark.table(f"wwi_stage.{stg_table_name}").drop("transaction_occured_when")

# COMMAND ----------

fact_dlt = DeltaTable.forName(spark, f"wwi_fct.{fact_table_name}")

fact_dlt.alias("target") \
    .merge(stg_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenMatchedUpdateAll() \
    .whenNotMatchedInsertAll() \
    .execute()

# COMMAND ----------

update_lineage_status(fact_table_name)