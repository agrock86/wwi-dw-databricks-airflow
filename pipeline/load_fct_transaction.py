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
fct_table_name = f"fct_{table_name}"

# COMMAND ----------

# Drop columns not required for the insert operation and cast to appropriate data types.
stg_df = spark.table(f"wwi_stg.{stg_table_name}") \
    .drop(f"{table_name}_key", "last_modified_when") \
    .drop("wwi_customer_id", "wwi_bill_to_customer_id", "wwi_supplier_id", "wwi_transaction_type_id", "wwi_payment_method_id") \
    .withColumn("total_excluding_tax", f.col("total_excluding_tax").cast("decimal(18,2)")) \
    .withColumn("tax_amount", f.col("tax_amount").cast("decimal(18,2)")) \
    .withColumn("total_including_tax", f.col("total_including_tax").cast("decimal(18,2)")) \
    .withColumn("outstanding_balance", f.col("outstanding_balance").cast("decimal(18,2)"))

# COMMAND ----------

fct_dt = DeltaTable.forName(spark, f"wwi_fct.{fct_table_name}")

# Append new records.
stg_df.write.format("delta").mode("append").saveAsTable(f"wwi_fct.{fct_table_name}")

# COMMAND ----------

update_lineage_status(fct_table_name)
