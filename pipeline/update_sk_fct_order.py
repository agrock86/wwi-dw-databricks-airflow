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

stg_order_df = spark.table(f"wwi_stg.{stg_table_name}").alias(stg_table_name) \
    .drop("city_key", "customer_key", "stock_item_key", "salesperson_key", "picker_key")
dim_city_df = spark.table(f"wwi_dim.dim_city").alias("dim_city")
dim_customer_df = spark.table(f"wwi_dim.dim_customer").alias("dim_customer")
dim_stock_item_df = spark.table(f"wwi_dim.dim_stock_item").alias("dim_stock_item")
dim_salesperson_df = spark.table(f"wwi_dim.dim_employee").alias("dim_salesperson")
dim_picker_df = spark.table(f"wwi_dim.dim_employee").alias("dim_picker")

stg_order_df = stg_order_df \
    .join(dim_city_df,
        (stg_order_df["wwi_city_id"] == dim_city_df["wwi_city_id"]) & 
        (stg_order_df["last_modified_when"] > dim_city_df["valid_from"]) & 
        (stg_order_df["last_modified_when"] <= dim_city_df["valid_to"]),
        "left"
    ) \
    .join(dim_customer_df,
        (stg_order_df["wwi_customer_id"] == dim_customer_df["wwi_customer_id"]) &
        (stg_order_df["last_modified_when"] > dim_customer_df["valid_from"]) &
        (stg_order_df["last_modified_when"] <= dim_customer_df["valid_to"]),
        "left"
    ) \
    .join(dim_stock_item_df,
        (stg_order_df["wwi_stock_item_id"] == dim_stock_item_df["wwi_stock_item_id"]) & 
        (stg_order_df["last_modified_when"] > dim_stock_item_df["valid_from"]) & 
        (stg_order_df["last_modified_when"] <= dim_stock_item_df["valid_to"]),
        "left"
    ) \
    .join(dim_salesperson_df,
        (stg_order_df["wwi_salesperson_id"] == dim_salesperson_df["wwi_employee_id"]) &
        (stg_order_df["last_modified_when"] > dim_salesperson_df["valid_from"]) &
        (stg_order_df["last_modified_when"] <= dim_salesperson_df["valid_to"]),
        "left"
    ) \
    .join(dim_picker_df,
        (stg_order_df["wwi_picker_id"] == dim_picker_df["wwi_employee_id"]) &
        (stg_order_df["last_modified_when"] > dim_picker_df["valid_from"]) &
        (stg_order_df["last_modified_when"] <= dim_picker_df["valid_to"]),
        "left"
    ) \
    .select(
        f"{stg_table_name}.*",
        "city_key",
        "customer_key",
        "stock_item_key",
        f.col("dim_salesperson.employee_key").alias("salesperson_key"),
        f.col("dim_picker.employee_key").alias("picker_key")
    ) \
    .na.fill({
        "city_key": -99,
        "customer_key": -99,
        "stock_item_key": -99,
        "salesperson_key": -99,
        "picker_key": -99
    })

# COMMAND ----------

stg_dlt = DeltaTable.forName(spark, f"wwi_stg.{stg_table_name}")

# Update the required dimension keys.
stg_dlt.alias("target") \
    .merge(stg_order_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenMatchedUpdate(
        set = {
            "city_key": "source.city_key",
            "customer_key": "source.customer_key",
            "stock_item_key": "source.stock_item_key",
            "salesperson_key": "source.salesperson_key",
            "picker_key": "source.picker_key"
        }
    ) \
    .execute()
