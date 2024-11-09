# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

# MAGIC %run ./etl_utils

# COMMAND ----------

from pyspark.sql import functions as f
from delta.tables import DeltaTable

# COMMAND ----------

table_name = "purchase"

stg_table_name = f"stg_{table_name}"
fct_table_name = f"fct_{table_name}"
pk_column_name = f"wwi_purchase_order_id"

# COMMAND ----------

# Drop columns not required for the insert operation.
stg_df = spark.table(f"wwi_stg.{stg_table_name}") \
    .drop(f"{table_name}_key", "last_modified_when") \
    .drop("wwi_supplier_id", "wwi_stock_item_id")

# COMMAND ----------

fct_dlt = DeltaTable.forName(spark, f"wwi_fct.{fct_table_name}")

# Delete records in the fact table that have changes in the source.
fct_dlt.alias("target") \
    .merge(stg_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenMatchedDelete() \
    .execute()

# Insert new records.
stg_df.write.format("delta").mode("append").saveAsTable(f"wwi_fct.{fct_table_name}")

# COMMAND ----------

update_lineage_status(fct_table_name)
