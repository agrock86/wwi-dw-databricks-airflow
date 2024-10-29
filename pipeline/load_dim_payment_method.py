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
dim_table_name = f"dim_{table_name}"
pk_column_name = f"wwi_{table_name}_id"

# COMMAND ----------

stg_df = spark.table(f"wwi_stage.{stg_table_name}")
closeoff_df = spark.table(f"wwi_stage.{stg_table_name}") \
    .groupBy(pk_column_name).agg(f.min("valid_from").alias("valid_from"))

# COMMAND ----------

dim_dlt = DeltaTable.forName(spark, f"wwi_dim.{dim_table_name}")
end_of_time = f.to_timestamp(f.lit("99991231 23:59:59.9999999"), "yyyyMMdd HH:mm:ss.SSSSSSSS")

# Close records in the dim table that have changes in the source.
dim_dlt.alias("target") \
    .merge(closeoff_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenMatchedUpdate(
        condition = f.col("target.valid_to") == end_of_time,
        set = {"valid_to": "source.valid_from"}
    ) \
    .execute()

# Insert new records.
dim_dlt.alias("target") \
    .merge(stg_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenNotMatchedInsert(
        values = {
            pk_column_name: f"source.{pk_column_name}",
            "payment_method": "source.payment_method",
            "valid_from": "source.valid_from",
            "valid_to": "source.valid_to",
            "lineage_key": "source.lineage_key"
        }
    ) \
    .execute()

# COMMAND ----------

update_lineage_status(dim_table_name)
