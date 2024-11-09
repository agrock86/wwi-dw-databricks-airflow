# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

from datetime import datetime, timedelta

from pyspark.sql import functions as f
from delta.tables import DeltaTable

# COMMAND ----------

# Date range to generate.
start_date = datetime(2000, 1, 1)
end_date = (datetime.utcnow() - timedelta(days=1)).replace(month=12).replace(day=31)

num_days = (end_date - start_date).days + 1
start_date = start_date.strftime('%Y-%m-%d')

# Transformations.
stg_date_df = spark.range(0, num_days) \
    .withColumn("id", f.col("id").cast("int")) \
    .withColumn("date", f.date_add(f.lit(start_date), f.col("id"))) \
    .withColumn("date_key", f.date_format("date", "yyyyMMdd").cast("bigint")) \
    .withColumn("day_number", f.dayofmonth("date")) \
    .withColumn("day", f.date_format("date", "d")) \
    .withColumn("month", f.date_format("date", "MMMM")) \
    .withColumn("short_month", f.date_format("date", "MMM")) \
    .withColumn("calendar_month_number", f.month("date")) \
    .withColumn("calendar_month_label", f.concat(
        f.lit("CY"),
        f.year("date"),
        f.lit("-"),
        f.substring(f.date_format("date", "MMM"), 1, 3))) \
    .withColumn("calendar_year", f.year("date")) \
    .withColumn("calendar_year_label", f.concat(f.lit("CY"), f.year("date"))) \
    .withColumn("fiscal_month_number", f.when(f.month("date").isin(11, 12), f.month("date") - 10).otherwise(f.month("date") + 2)) \
    .withColumn("fiscal_month_label", f.concat(
        f.lit("FY"),
        f.when(f.month("date").isin(11, 12), f.year("date") + 1).otherwise(f.year("date")),
        f.lit("-"),
        f.substring(f.date_format("date", "MMM"), 1, 3))) \
    .withColumn("fiscal_year", f.when(f.month("date").isin(11, 12), f.year("date") + 1).otherwise(f.year("date"))) \
    .withColumn("fiscal_year_label", f.concat(
        f.lit("FY"),
        f.when(f.month("date").isin(11, 12), f.year("date") + 1).otherwise(f.year("date")))) \
    .withColumn("iso_week_number", f.weekofyear("date")) \
    .drop("id")

# COMMAND ----------

# Insert overwrite.
stg_date_df.write.format("delta").mode("overwrite").saveAsTable("wwi_dim.dim_date")
