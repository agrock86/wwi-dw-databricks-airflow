# Databricks notebook source
# MAGIC %sql
# MAGIC use catalog wide_world_importers_dw

# COMMAND ----------

from datetime import datetime

from pyspark.sql import functions as f
from delta.tables import DeltaTable

# COMMAND ----------

def generate_lineage_key(table_name, new_cutoff_time):
    data_load_started_when = datetime.now().strftime("%Y-%m-%d %H:%M:%S.%f")

    spark.sql(f"""
        INSERT INTO wwi_stage.etl_lineage(data_load_started, table_name, data_load_completed, was_successful, source_system_cutoff_time)
        VALUES('{data_load_started_when}', '{table_name}', NULL, 0, '{new_cutoff_time}')"""
    )

    etl_lineage_df = spark.table("wwi_stage.etl_lineage") \
        .filter(f.col("table_name") == table_name) \
        .filter(f.col("data_load_started") == f.to_timestamp(f.lit(data_load_started_when), "yyyy-MM-dd HH:mm:ss.SSSSSS")) \
        .orderBy(f.col("lineage_key").desc()) \
        .limit(1)

    return etl_lineage_df.first()[0]

# COMMAND ----------

def get_last_lineage_key(table_name):
    etl_lineage_df = spark.table("wwi_stage.etl_lineage") \
        .filter(f.col("table_name") == table_name) \
        .filter(f.col("data_load_completed").isNull()) \
        .orderBy(f.col("lineage_key").desc()) \
        .select("lineage_key") \
        .limit(1)

    return etl_lineage_df.first()[0]

# COMMAND ----------

def get_lineage_cutoff_time(lineage_key):
    etl_lineage_df = spark.table("wwi_stage.etl_lineage") \
        .filter(f.col("lineage_key") == lineage_key) \
        .select(f.date_format("source_system_cutoff_time", "yyyy-MM-dd HH:mm:ss.SSSSSS"))

    return etl_lineage_df.first()[0]

# COMMAND ----------

def get_control_metadata(table_name):
    etl_control_df = spark.table("wwi_stage.etl_control") \
        .filter(f.col("table_name") == table_name) \
        .select(
            "datasource_name",
            f.date_format("cutoff_time", "yyyy-MM-dd HH:mm:ss.SSSSSS").alias("cutoff_time")
        )
    
    if (etl_control_df.first() is None):
        raise Exception("Invalid ETL table name {table_name}")

    return etl_control_df.first().asDict()

# COMMAND ----------

def get_datasource_name(table_name):
    etl_control_df = spark.table("wwi_stage.etl_control") \
        .filter(f.col("table_name") == table_name) \
        .select("datasource_name")
    
    if (etl_control_df.first() is None):
        raise Exception("Invalid ETL table name {table_name}")

    return etl_control_df.first()[0]

# COMMAND ----------

def get_wwi_db_dataframe(sp_name, sp_params):
    # Get DB login credentials from Azure Key Vault.
    wwi_db_host = dbutils.secrets.get(scope = "wwi-migration", key = "wwi-db-host")
    wwi_db_name = dbutils.secrets.get(scope = "wwi-migration", key = "wwi-db-name")
    wwi_db_username = dbutils.secrets.get(scope = "wwi-migration", key = "wwi-db-username")
    wwi_db_password = dbutils.secrets.get(scope = "wwi-migration", key = "wwi-db-password")
    
    sql_query = f"EXEC {sp_name} " + (", ".join([f"@{key} = '{value}'" for key, value in sp_params.items()]))

    df = spark.read.format("jdbc") \
        .option("url", f"jdbc:sqlserver://{wwi_db_host}:1433;database={wwi_db_name};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;") \
        .option("prepareQuery", sql_query) \
        .option("query", "select * from result") \
        .option("user", wwi_db_username) \
        .option("password", wwi_db_password) \
        .option("driver", "com.microsoft.sqlserver.jdbc.SQLServerDriver") \
        .load()
    
    # Convert columns names to lower case and replace spaces with underscores.
    for col in df.columns:
        df = df.withColumnRenamed(col, col.lower().replace(" ", "_"))
    
    return df

# COMMAND ----------

def update_lineage_status(table_name):
    lineage_key = get_last_lineage_key(table_name)

    # Update ELT lineage and cutoff tables with new status.
    etl_lineage_dlt = DeltaTable.forName(spark, "wwi_stage.etl_lineage")
    etl_control_dlt = DeltaTable.forName(spark, "wwi_stage.etl_control")

    # Mark as completed.
    etl_lineage_dlt.update(
        condition = f.col("lineage_key") == lineage_key,
        set = {"data_load_completed": f.current_timestamp(), "was_successful": f.lit(1)}
    )

    lineage_cutoff_time = get_lineage_cutoff_time(lineage_key)

    # Update last time data was loaded.
    etl_control_dlt.update(
        condition = f.col("table_name") == table_name,
        set = {"cutoff_time": f.lit(lineage_cutoff_time)}
    )
