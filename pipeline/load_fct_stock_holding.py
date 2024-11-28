# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

# MAGIC %run ./etl_utils

# COMMAND ----------

from pyspark.sql import functions as f
from delta.tables import DeltaTable

# COMMAND ----------

table_name = "stock_holding"

stg_table_name = f"stg_{table_name}"
fct_table_name = f"fct_{table_name}"

# COMMAND ----------

# Drop columns not required for the insert operation and cast to appropriate data types.
stg_stock_holding_df = spark.table(f"wwi_stg.{stg_table_name}") \
    .drop(f"{table_name}_key") \
    .drop("wwi_stock_item_id") \
    .withColumn("last_cost_price", f.col("last_cost_price").cast("decimal(18,2)"))

# COMMAND ----------

fct_stock_holding_dt = DeltaTable.forName(spark, f"wwi_fct.{fct_table_name}")

# Truncate and insert new records.
stg_stock_holding_df.write.format("delta").mode("overwrite").saveAsTable(f"wwi_fct.{fct_table_name}")

# COMMAND ----------

update_lineage_status(fct_table_name)
