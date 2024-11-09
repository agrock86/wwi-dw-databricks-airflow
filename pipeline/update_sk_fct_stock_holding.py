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
pk_column_name = f"{table_name}_key"

# COMMAND ----------

stg_stock_holding_df = spark.table(f"wwi_stg.{stg_table_name}").alias(stg_table_name).drop("stock_item_key")
dim_stock_item_df = spark.table(f"wwi_dim.dim_stock_item").alias("dim_stock_item")

stg_stock_holding_df = stg_stock_holding_df \
    .join(dim_stock_item_df,
        stg_stock_holding_df["wwi_stock_item_id"] == dim_stock_item_df["wwi_stock_item_id"],
        "left"
    ) \
    .select(f"{stg_table_name}.*", "stock_item_key") \
    .na.fill({
        "stock_item_key": 0,
    })

# COMMAND ----------

stg_dt = DeltaTable.forName(spark, f"wwi_stg.{stg_table_name}")

# Update the required dimension keys.
stg_dt.alias("target") \
    .merge(stg_stock_holding_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenMatchedUpdate(
        set = {
            "stock_item_key": "source.stock_item_key"
        }
    ) \
    .execute()
