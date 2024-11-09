# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

# MAGIC %run ./etl_utils

# COMMAND ----------

from pyspark.sql import functions as f
from delta.tables import DeltaTable

# COMMAND ----------


table_name = "stock_item"

stg_table_name = f"stg_{table_name}"
dim_table_name = f"dim_{table_name}"
pk_column_name = f"wwi_{table_name}_id"

# COMMAND ----------

stg_df = spark.table(f"wwi_stage.{stg_table_name}")
closeoff_df = spark.table(f"wwi_stage.{stg_table_name}") \
    .groupBy(pk_column_name).agg(f.min("valid_from").alias("valid_from"))

# COMMAND ----------

dim_dt = DeltaTable.forName(spark, f"wwi_dim.{dim_table_name}")
end_of_time = f.to_timestamp(f.lit("99991231 23:59:59.9999999"), "yyyyMMdd HH:mm:ss.SSSSSSSS")

# Close records in the dim table that have changes in the source.
dim_dt.alias("target") \
    .merge(closeoff_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenMatchedUpdate(
        condition = f.col("target.valid_to") == end_of_time,
        set = {"valid_to": "source.valid_from"}
    ) \
    .execute()

# Insert new records.
dim_dt.alias("target") \
    .merge(stg_df.alias("source"), f"target.{pk_column_name} = source.{pk_column_name}") \
    .whenNotMatchedInsert(
        values = {
            pk_column_name: f"source.{pk_column_name}",
            "stock_item": "source.stock_item",
            "color": "source.color",
            "selling_package": "source.selling_package",
            "buying_package": "source.buying_package",
            "brand": "source.brand",
            "size": "source.size",
            "lead_time_days": "source.lead_time_days",
            "quantity_per_outer": "source.quantity_per_outer",
            "is_chiller_stock": "source.is_chiller_stock",
            "barcode": "source.barcode",
            "tax_rate": "source.tax_rate",
            "unit_price": "source.unit_price",
            "recommended_retail_price": "source.recommended_retail_price",
            "typical_weight_per_unit": "source.typical_weight_per_unit",
            "photo": "source.photo",
            "valid_from": "source.valid_from",
            "valid_to": "source.valid_to",
            "lineage_key": "source.lineage_key"
        }
    ) \
    .execute()

# COMMAND ----------

update_lineage_status(dim_table_name)
