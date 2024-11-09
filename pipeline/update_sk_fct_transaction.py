# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

# MAGIC %run ./etl_utils

# COMMAND ----------

from pyspark.sql import functions as f
from delta.tables import DeltaTable

# COMMAND ----------


table_name = "transaction"

stg_table_name = f"stg_{table_name}"
pk_column_name = f"{table_name}_key"

# COMMAND ----------

stg_transaction_df = spark.table(f"wwi_stg.{stg_table_name}").alias(stg_table_name) \
    .drop("customer_key", "bill_to_customer_key", "supplier_key", "transaction_type_key", "payment_method_key")
dim_customer_df = spark.table(f"wwi_dim.dim_customer").alias("dim_customer")
dim_bill_customer_df = spark.table(f"wwi_dim.dim_customer").alias("dim_bill_customer")
dim_supplier_df = spark.table(f"wwi_dim.dim_supplier").alias("dim_supplier")
dim_transaction_type_df = spark.table(f"wwi_dim.dim_transaction_type").alias("dim_transaction_type")
dim_payment_method_df = spark.table(f"wwi_dim.dim_payment_method").alias("dim_payment_method")

stg_transaction_df = stg_transaction_df \
    .join(dim_customer_df,
        (stg_transaction_df["wwi_customer_id"] == dim_customer_df["wwi_customer_id"]) & 
        (stg_transaction_df["last_modified_when"] > dim_customer_df["valid_from"]) & 
        (stg_transaction_df["last_modified_when"] <= dim_customer_df["valid_to"]),
        "left"
    ) \
    .join(dim_bill_customer_df,
        (stg_transaction_df["wwi_bill_to_customer_id"] == dim_bill_customer_df["wwi_customer_id"]) &
        (stg_transaction_df["last_modified_when"] > dim_bill_customer_df["valid_from"]) &
        (stg_transaction_df["last_modified_when"] <= dim_bill_customer_df["valid_to"]),
        "left"
    ) \
    .join(dim_supplier_df,
        (stg_transaction_df["wwi_supplier_id"] == dim_supplier_df["wwi_supplier_id"]) & 
        (stg_transaction_df["last_modified_when"] > dim_supplier_df["valid_from"]) & 
        (stg_transaction_df["last_modified_when"] <= dim_supplier_df["valid_to"]),
        "left"
    ) \
    .join(dim_transaction_type_df,
        (stg_transaction_df["wwi_transaction_type_id"] == dim_transaction_type_df["wwi_transaction_type_id"]) &
        (stg_transaction_df["last_modified_when"] > dim_transaction_type_df["valid_from"]) &
        (stg_transaction_df["last_modified_when"] <= dim_transaction_type_df["valid_to"]),
        "left"
    ) \
    .join(dim_payment_method_df,
        (stg_transaction_df["wwi_payment_method_id"] == dim_payment_method_df["wwi_payment_method_id"]) &
        (stg_transaction_df["last_modified_when"] > dim_payment_method_df["valid_from"]) &
        (stg_transaction_df["last_modified_when"] <= dim_payment_method_df["valid_to"]),
        "left"
    ) \
    .select(
        f"{stg_table_name}.*",
        "dim_customer.customer_key",
        f.col("dim_bill_customer.customer_key").alias("bill_to_customer_key"),
        "supplier_key",
        "transaction_type_key",
        "payment_method_key"
    ) \
    .na.fill({
        "customer_key": -99,
        "bill_to_customer_key": -99,
        "supplier_key": -99,
        "transaction_type_key": -99,
        "payment_method_key": -99
    })

# COMMAND ----------

stg_dt = DeltaTable.forName(spark, f"wwi_stg.{stg_table_name}")

# Update the required dimension keys.
stg_dt.alias("target") \
    .merge(stg_transaction_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenMatchedUpdate(
        set = {
            "customer_key": "source.customer_key",
            "bill_to_customer_key": "source.bill_to_customer_key",
            "supplier_key": "source.supplier_key",
            "transaction_type_key": "source.transaction_type_key",
            "payment_method_key": "source.payment_method_key"
        }
    ) \
    .execute()
