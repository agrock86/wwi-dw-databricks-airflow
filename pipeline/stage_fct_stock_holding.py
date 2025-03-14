# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

# MAGIC %run ./etl_utils

# COMMAND ----------

from pyspark.sql import functions as f

# COMMAND ----------


table_name = "stock_holding"
target_etl_cutoff_time = dbutils.widgets.get("target_etl_cutoff_time")

stg_table_name = f"stg_{table_name}"
fct_table_name = f"fct_{table_name}"
pk_column_name = f"{table_name}_key"

# Lineage ID to track batch status.
lineage_key = generate_lineage_key(fct_table_name, target_etl_cutoff_time)
# ETL control metadata, which includes datasource name and last cutoff time.
control_metadata = get_control_metadata(fct_table_name)

# COMMAND ----------

# Get updates from source.
stg_stock_holding_df = get_wwi_db_dataframe(control_metadata["datasource_name"])

# COMMAND ----------

# Add lineage key for reference.
# Add columns for dimension keys.
stg_stock_holding_df = stg_stock_holding_df.withColumn("lineage_key", f.lit(lineage_key).cast("bigint")) \
    .withColumn(pk_column_name, f.monotonically_increasing_id()) \
    .withColumn("stock_item_key", f.lit(None).cast("bigint"))

# COMMAND ----------

# Insert overwrite.
stg_stock_holding_df.write.format("delta").mode("overwrite").saveAsTable(f"wwi_stg.{stg_table_name}")
