use catalog wide_world_importers_dw;

create schema if not exists wwi_stage;

use schema wwi_stage;

drop table if exists wwi_stage.etl_control;
create table wwi_stage.etl_control
(
  table_name string not null,
  datasource_name string,
  cutoff_time timestamp not null
);

insert into wwi_stage.etl_control (table_name, datasource_name, cutoff_time) values
('dim_transaction_type', 'Integration.GetTransactionTypeUpdates', '2010-01-01 00:00:00.000'),
('dim_payment_method', 'Integration.GetPaymentMethodUpdates', '2010-01-01 00:00:00.000'),
('fct_stock_holding', 'Integration.GetStockHoldingUpdates', '2010-01-01 00:00:00.000'),
('fct_transaction', 'Integration.GetTransactionUpdates', '2010-01-01 00:00:00.000'),
('dim_stock_item', 'Integration.GetStockItemUpdates', '2010-01-01 00:00:00.000'),
('fct_movement', 'Integration.GetMovementUpdates', '2010-01-01 00:00:00.000'),
('dim_customer', 'Integration.GetCustomerUpdates', '2010-01-01 00:00:00.000'),
('dim_employee', 'Integration.GetEmployeeUpdates', '2010-01-01 00:00:00.000'),
('dim_supplier', 'Integration.GetSupplierUpdates', '2010-01-01 00:00:00.000'),
('fct_purchase', 'Integration.GetPurchaseUpdates', '2010-01-01 00:00:00.000'),
('fct_order', 'Integration.GetOrderUpdates', '2010-01-01 00:00:00.000'),
('dim_date', null, '2010-01-01 00:00:00.000'),
('dim_city', 'Integration.GetCityUpdates', '2010-01-01 00:00:00.000'),
('fct_sale', 'Integration.GetSaleUpdates', '2010-01-01 00:00:00.000');

drop table if exists wwi_stage.etl_lineage;
create table wwi_stage.etl_lineage
(
  lineage_key bigint not null generated always as identity,
  data_load_started timestamp not null,
  table_name string not null,
  data_load_completed timestamp,
  was_successful boolean not null,
  source_system_cutoff_time timestamp not null
);


