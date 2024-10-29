# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

# MAGIC %run ./etl_utils

# COMMAND ----------

from pyspark.sql import functions as f

# COMMAND ----------


table_name = dbutils.widgets.get("table_name")
target_etl_cutoff_time = dbutils.widgets.get("target_etl_cutoff_time")

stg_table_name = f"stg_{table_name}"
dim_table_name = f"dim_{table_name}"

# Lineage ID to track batch status.
lineage_key = generate_lineage_key(dim_table_name, target_etl_cutoff_time)
# ETL control metadata, which includes datasource name and last cutoff time.
control_metadata = get_control_metadata(dim_table_name)

# COMMAND ----------

sp_params = {
    "LastCutoff": control_metadata["cutoff_time"],
    "NewCutoff": target_etl_cutoff_time
}

# Get updates from source.
stg_df = get_wwi_db_dataframe(control_metadata["datasource_name"], sp_params)

# COMMAND ----------

# Add lineage key for reference.
stg_df = stg_df.withColumn("lineage_key", f.lit(lineage_key).cast("bigint"))

# COMMAND ----------

# Insert overwrite.
stg_df.write.format("delta").mode("overwrite").saveAsTable(f"wwi_stage.{stg_table_name}")
