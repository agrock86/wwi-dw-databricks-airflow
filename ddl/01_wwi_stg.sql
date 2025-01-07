use catalog wide_world_importers_dwh;

create schema if not exists wwi_stg;

use schema wwi_stg;

set spark.databricks.delta.retentionDurationCheck.enabled = false;

drop table if exists wwi_stg.etl_control;
create table wwi_stg.etl_control
(
  table_name string not null,
  datasource_name string,
  cutoff_time timestamp not null
);

insert into wwi_stg.etl_control (table_name, datasource_name, cutoff_time) values
('dim_transaction_type', 'Integration.GetTransactionTypeUpdates', '2000-01-01 00:00:00.000'),
('dim_payment_method', 'Integration.GetPaymentMethodUpdates', '2000-01-01 00:00:00.000'),
('fct_stock_holding', 'Integration.GetStockHoldingUpdates', '2000-01-01 00:00:00.000'),
('fct_transaction', 'Integration.GetTransactionUpdates', '2000-01-01 00:00:00.000'),
('dim_stock_item', 'Integration.GetStockItemUpdates', '2000-01-01 00:00:00.000'),
('fct_movement', 'Integration.GetMovementUpdates', '2000-01-01 00:00:00.000'),
('dim_customer', 'Integration.GetCustomerUpdates', '2000-01-01 00:00:00.000'),
('dim_employee', 'Integration.GetEmployeeUpdates', '2000-01-01 00:00:00.000'),
('dim_supplier', 'Integration.GetSupplierUpdates', '2000-01-01 00:00:00.000'),
('fct_purchase', 'Integration.GetPurchaseUpdates', '2000-01-01 00:00:00.000'),
('fct_order', 'Integration.GetOrderUpdates', '2000-01-01 00:00:00.000'),
('dim_date', null, '2000-01-01 00:00:00.000'),
('dim_city', 'Integration.GetCityUpdates', '2000-01-01 00:00:00.000'),
('fct_sale', 'Integration.GetSaleUpdates', '2000-01-01 00:00:00.000');

vacuum wwi_stg.etl_control retain 0 hours;

drop table if exists wwi_stg.etl_lineage;
create table wwi_stg.etl_lineage
(
  lineage_key bigint not null generated always as identity,
  data_load_started timestamp not null,
  table_name string not null,
  data_load_completed timestamp,
  was_successful boolean not null,
  source_system_cutoff_time timestamp not null
);

vacuum wwi_stg.etl_lineage retain 0 hours;