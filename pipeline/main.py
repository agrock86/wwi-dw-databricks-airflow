# Databricks notebook source
# MAGIC %run ./init

# COMMAND ----------

target_etl_cutoff_time = (datetime.now() - timedelta(minutes=5)).replace(microsecond=0)
target_etl_cutoff_time = target_etl_cutoff_time.strftime("%Y-%m-%d %H:%M:%S.%f")
