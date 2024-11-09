# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

# MAGIC %run ./etl_utils

# COMMAND ----------

from pyspark.sql import functions as f
from pyspark.sql import Window
from delta.tables import DeltaTable

# COMMAND ----------


table_name = "order"

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

# When a single fact record matches multiple records from a dimension, take only the earliest by valid_from date.
window_spec = Window.partitionBy(pk_column_name).orderBy("valid_from")

# After each row_num calculation, drop valid_from to avoid ambiguous colum references when joining with other dimensions.
stg_order_df = stg_order_df \
    .join(dim_city_df,
        (stg_order_df["wwi_city_id"] == dim_city_df["wwi_city_id"]) & 
        (stg_order_df["last_modified_when"] > dim_city_df["valid_from"]) & 
        (stg_order_df["last_modified_when"] <= dim_city_df["valid_to"]),
        "left"
    ) \
    .withColumn("row_num", f.row_number().over(window_spec)).filter(f.col("row_num") == 1).drop("valid_from") \
    .join(dim_customer_df,
        (stg_order_df["wwi_customer_id"] == dim_customer_df["wwi_customer_id"]) &
        (stg_order_df["last_modified_when"] > dim_customer_df["valid_from"]) &
        (stg_order_df["last_modified_when"] <= dim_customer_df["valid_to"]),
        "left"
    ) \
    .withColumn("row_num", f.row_number().over(window_spec)).filter(f.col("row_num") == 1).drop("valid_from") \
    .join(dim_stock_item_df,
        (stg_order_df["wwi_stock_item_id"] == dim_stock_item_df["wwi_stock_item_id"]) & 
        (stg_order_df["last_modified_when"] > dim_stock_item_df["valid_from"]) & 
        (stg_order_df["last_modified_when"] <= dim_stock_item_df["valid_to"]),
        "left"
    ) \
    .withColumn("row_num", f.row_number().over(window_spec)).filter(f.col("row_num") == 1).drop("valid_from") \
    .join(dim_salesperson_df,
        (stg_order_df["wwi_salesperson_id"] == dim_salesperson_df["wwi_employee_id"]) &
        (stg_order_df["last_modified_when"] > dim_salesperson_df["valid_from"]) &
        (stg_order_df["last_modified_when"] <= dim_salesperson_df["valid_to"]),
        "left"
    ) \
    .withColumn("row_num", f.row_number().over(window_spec)).filter(f.col("row_num") == 1).drop("valid_from") \
    .join(dim_picker_df,
        (stg_order_df["wwi_picker_id"] == dim_picker_df["wwi_employee_id"]) &
        (stg_order_df["last_modified_when"] > dim_picker_df["valid_from"]) &
        (stg_order_df["last_modified_when"] <= dim_picker_df["valid_to"]),
        "left"
    ) \
    .withColumn("row_num", f.row_number().over(window_spec)).filter(f.col("row_num") == 1).drop("valid_from") \
    .select(
        f"{stg_table_name}.*",
        "city_key",
        "customer_key",
        "stock_item_key",
        f.col("dim_salesperson.employee_key").alias("salesperson_key"),
        f.col("dim_picker.employee_key").alias("picker_key")
    ).drop("row_num") \
    .na.fill({
        "city_key": 0,
        "customer_key": 0,
        "stock_item_key": 0,
        "salesperson_key": 0,
        "picker_key": 0
    })

# COMMAND ----------

stg_dt = DeltaTable.forName(spark, f"wwi_stg.{stg_table_name}")

# Update the required dimension keys.
stg_dt.alias("target") \
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
