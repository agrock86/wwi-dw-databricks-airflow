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
pk_column_name = f"{table_name}_key"

# COMMAND ----------

stg_purchase_df = spark.table(f"wwi_stg.{stg_table_name}").alias(stg_table_name) \
    .drop("supplier_key", "stock_item_key")
dim_supplier_df = spark.table(f"wwi_dim.dim_supplier").alias("dim_supplier")
dim_stock_item_df = spark.table(f"wwi_dim.dim_stock_item").alias("dim_stock_item")

stg_purchase_df = stg_purchase_df \
    .join(dim_supplier_df,
        (stg_purchase_df["wwi_supplier_id"] == dim_supplier_df["wwi_supplier_id"]) & 
        (stg_purchase_df["last_modified_when"] > dim_supplier_df["valid_from"]) & 
        (stg_purchase_df["last_modified_when"] <= dim_supplier_df["valid_to"]),
        "left"
    ) \
    .join(dim_stock_item_df,
        (stg_purchase_df["wwi_stock_item_id"] == dim_stock_item_df["wwi_stock_item_id"]) & 
        (stg_purchase_df["last_modified_when"] > dim_stock_item_df["valid_from"]) & 
        (stg_purchase_df["last_modified_when"] <= dim_stock_item_df["valid_to"]),
        "left"
    ) \
    .select(f"{stg_table_name}.*", "supplier_key", "stock_item_key") \
    .na.fill({
        "supplier_key": -99,
        "stock_item_key": -99
    })

# COMMAND ----------

stg_dlt = DeltaTable.forName(spark, f"wwi_stg.{stg_table_name}")

# Update the required dimension keys.
stg_dlt.alias("target") \
    .merge(stg_purchase_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenMatchedUpdate(
        set = {
            "supplier_key": "source.supplier_key",
            "stock_item_key": "source.stock_item_key"
        }
    ) \
    .execute()
