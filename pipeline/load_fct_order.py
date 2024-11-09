# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

# MAGIC %run ./etl_utils

# COMMAND ----------

from pyspark.sql import functions as f
from delta.tables import DeltaTable

# COMMAND ----------

table_name = "order"

stg_table_name = f"stg_{table_name}"
fct_table_name = f"fct_{table_name}"
pk_column_name = f"wwi_{table_name}_id"

# COMMAND ----------

# Drop columns not required for the insert operation and cast to appropriate data types.
stg_order_df = spark.table(f"wwi_stg.{stg_table_name}") \
    .drop(f"{table_name}_key", "last_modified_when") \
    .drop("wwi_city_id", "wwi_customer_id", "wwi_stock_item_id", "wwi_salesperson_id", "wwi_picker_id") \
    .withColumn("unit_price", f.col("unit_price").cast("decimal(18,2)")) \
    .withColumn("tax_rate", f.col("tax_rate").cast("decimal(18,3)")) \
    .withColumn("total_excluding_tax", f.col("total_excluding_tax").cast("decimal(18,2)")) \
    .withColumn("tax_amount", f.col("tax_amount").cast("decimal(18,2)")) \
    .withColumn("total_including_tax", f.col("total_including_tax").cast("decimal(18,2)"))

# COMMAND ----------

fct_order_dt = DeltaTable.forName(spark, f"wwi_fct.{fct_table_name}")

# Delete records in the fact table that have changes in the source.
fct_order_dt.alias("target") \
    .merge(stg_order_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenMatchedDelete() \
    .execute()

# Insert new records.
stg_order_df.write.format("delta").mode("append").saveAsTable(f"wwi_fct.{fct_table_name}")

# COMMAND ----------

update_lineage_status(fct_table_name)
