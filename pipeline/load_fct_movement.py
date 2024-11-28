# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

# MAGIC %run ./etl_utils

# COMMAND ----------

from pyspark.sql import functions as f
from delta.tables import DeltaTable

# COMMAND ----------

table_name = "movement"

stg_table_name = f"stg_{table_name}"
fct_table_name = f"fct_{table_name}"
pk_column_name = f"wwi_stock_item_transaction_id"

# COMMAND ----------

# Drop columns not required for the insert operation and apply required transformations.
stg_movement_df = spark.table(f"wwi_stg.{stg_table_name}") \
    .drop("movement_key", "transaction_occured_when") \
    .withColumn("date_key", f.date_format("date_key", "yyyyMMdd").cast("bigint"))

# COMMAND ----------

fct_movement_dt = DeltaTable.forName(spark, f"wwi_fct.{fct_table_name}")

fct_movement_dt.alias("target") \
    .merge(stg_movement_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenMatchedUpdateAll() \
    .whenNotMatchedInsertAll() \
    .execute()

# COMMAND ----------

update_lineage_status(fct_table_name)
