# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

# MAGIC %run ./etl_utils

# COMMAND ----------

from pyspark.sql import functions as f
from pyspark.sql import Window
from delta.tables import DeltaTable

# COMMAND ----------


table_name = "stock_holding"

stg_table_name = f"stg_{table_name}"
pk_column_name = f"{table_name}_key"

# COMMAND ----------

stg_stock_holding_df = spark.table(f"wwi_stg.{stg_table_name}").alias(stg_table_name) \
    .drop("stock_item_key")

dim_stock_item_df = spark.table(f"wwi_dim.dim_stock_item").alias("dim_stock_item")

# When a single fact record matches multiple records from a dimension, take only the earliest by valid_from date.
window_spec = Window.partitionBy(pk_column_name).orderBy("valid_from")

# After each row_num calculation, drop valid_from to avoid ambiguous colum references when joining with other dimensions.
stg_stock_holding_df = stg_stock_holding_df \
    .join(dim_stock_item_df,
        stg_stock_holding_df["wwi_stock_item_id"] == dim_stock_item_df["wwi_stock_item_id"],
        "left"
    ) \
    .withColumn("row_num", f.row_number().over(window_spec)).filter(f.col("row_num") == 1).drop("valid_from") \
    .select(f"{stg_table_name}.*", "stock_item_key").drop("row_num") \
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
