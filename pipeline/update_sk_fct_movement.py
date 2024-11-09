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
pk_column_name = f"{table_name}_key"

# COMMAND ----------

stg_movement_df = spark.table(f"wwi_stg.{stg_table_name}").alias(stg_table_name) \
    .drop("stock_item_key", "customer_key", "supplier_key", "transaction_type_key")
    
dim_stock_item_df = spark.table(f"wwi_dim.dim_stock_item").alias("dim_stock_item")
dim_customer_df = spark.table(f"wwi_dim.dim_customer").alias("dim_customer")
dim_supplier_df = spark.table(f"wwi_dim.dim_supplier").alias("dim_supplier")
dim_transaction_type_df = spark.table(f"wwi_dim.dim_transaction_type").alias("dim_transaction_type")

stg_movement_df = stg_movement_df \
    .join(dim_stock_item_df,
        (stg_movement_df["wwi_stock_item_id"] == dim_stock_item_df["wwi_stock_item_id"]) & 
        (stg_movement_df["transaction_occurred_when"] > dim_stock_item_df["valid_from"]) & 
        (stg_movement_df["transaction_occurred_when"] <= dim_stock_item_df["valid_to"]),
        "left"
    ) \
    .join(dim_customer_df,
        (stg_movement_df["wwi_customer_id"] == dim_customer_df["wwi_customer_id"]) &
        (stg_movement_df["transaction_occurred_when"] > dim_customer_df["valid_from"]) &
        (stg_movement_df["transaction_occurred_when"] <= dim_customer_df["valid_to"]),
        "left"
    ) \
    .join(dim_supplier_df,
        (stg_movement_df["wwi_supplier_id"] == dim_supplier_df["wwi_supplier_id"]) &
        (stg_movement_df["transaction_occurred_when"] > dim_supplier_df["valid_from"]) &
        (stg_movement_df["transaction_occurred_when"] <= dim_supplier_df["valid_to"]),
        "left"
    ) \
    .join(dim_transaction_type_df,
        (stg_movement_df["wwi_transaction_type_id"] == dim_transaction_type_df["wwi_transaction_type_id"]) &
        (stg_movement_df["transaction_occurred_when"] > dim_transaction_type_df["valid_from"]) &
        (stg_movement_df["transaction_occurred_when"] <= dim_transaction_type_df["valid_to"]),
        "left"
    ) \
    .select(f"{stg_table_name}.*", "stock_item_key", "customer_key", "supplier_key", "transaction_type_key") \
    .na.fill({
        "stock_item_key": 0,
        "customer_key": 0,
        "supplier_key": 0,
        "transaction_type_key": 0
    })

# COMMAND ----------

stg_dt = DeltaTable.forName(spark, f"wwi_stg.{stg_table_name}")

# Update the required dimension keys.
stg_dt.alias("target") \
    .merge(stg_movement_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenMatchedUpdate(
        set = {
            "stock_item_key": "source.stock_item_key",
            "customer_key": "source.customer_key",
            "supplier_key": "source.supplier_key",
            "transaction_type_key": "source.transaction_type_key"
        }
    ) \
    .execute()
