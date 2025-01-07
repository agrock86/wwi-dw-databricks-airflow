use catalog wide_world_importers_dwh;

create schema if not exists wwi_dim;

use schema wwi_dim;

set spark.databricks.delta.retentionDurationCheck.enabled = false;

drop table if exists wwi_dim.dim_date;
create table wwi_dim.dim_date
(
    date date,
    date_key bigint,
    day_number int,
    day string,
    month string,
    short_month string,
    calendar_month_number int,
    calendar_month_label string,
    calendar_year int,
    calendar_year_label string,
    fiscal_month_number int,
    fiscal_month_label string,
    fiscal_year int,
    fiscal_year_label string,
    iso_week_number int,
    primary key(date_key)
);

vacuum wwi_dim.dim_date retain 0 hours;

drop table if exists wwi_dim.dim_city;
create table wwi_dim.dim_city
(
	city_key bigint not null generated always as identity,
	wwi_city_id int not null,
	city string not null,
	state_province string not null,
	country string not null,
	continent string not null,
	sales_territory string not null,
	region string not null,
	subregion string not null,
	location binary,
	latest_recorded_population bigint not null,
	valid_from timestamp not null,
	valid_to timestamp not null,
  lineage_key bigint not null,
	primary key(city_key)
);

vacuum wwi_dim.dim_city retain 0 hours;

drop table if exists wwi_dim.dim_customer;
create table wwi_dim.dim_customer
(
	customer_key bigint not null generated always as identity,
	wwi_customer_id int not null,
	customer string not null,
	bill_to_customer string not null,
	category string not null,
	buying_group string not null,
	primary_contact string not null,
	postal_code string not null,
	valid_from timestamp not null,
	valid_to timestamp not null,
	lineage_key bigint not null,
	primary key(customer_key)
);

vacuum wwi_dim.dim_customer retain 0 hours;

drop table if exists wwi_dim.dim_employee;
create table wwi_dim.dim_employee
(
	employee_key bigint not null generated always as identity,
	wwi_employee_id int not null,
	employee string not null,
	preferred_name string not null,
	is_salesperson boolean not null,
	photo binary,
	valid_from timestamp not null,
	valid_to timestamp not null,
	lineage_key bigint not null,
	primary key(employee_key)
);

vacuum wwi_dim.dim_employee retain 0 hours;

drop table if exists wwi_dim.dim_payment_method;
create table wwi_dim.dim_payment_method
(
	payment_method_key bigint not null generated always as identity,
	wwi_payment_method_id int not null,
	payment_method string not null,
	valid_from timestamp not null,
	valid_to timestamp not null,
	lineage_key int not null,
	primary key(payment_method_key)
);

vacuum wwi_dim.dim_payment_method retain 0 hours;

drop table if exists wwi_dim.dim_stock_item;
create table wwi_dim.dim_stock_item
(
	stock_item_key bigint generated always as identity,
	wwi_stock_item_id int not null,
	stock_item string not null,
	color string not null,
	selling_package string not null,
	buying_package string not null,
	brand string not null,
	size string not null,
	lead_time_days int not null,
	quantity_per_outer int not null,
	is_chiller_stock boolean not null,
	barcode string,
	tax_rate decimal(18, 3) not null,
	unit_price decimal(18, 2) not null,
	recommended_retail_price decimal(18, 2),
	typical_weight_per_unit decimal(18, 3) not null,
	photo binary,
	valid_from timestamp not null,
	valid_to timestamp not null,
	lineage_key bigint not null,
	primary key(stock_item_key)
);

vacuum wwi_dim.dim_stock_item retain 0 hours;

drop table if exists wwi_dim.dim_supplier;
create table wwi_dim.dim_supplier
(
  supplier_key bigint generated always as identity,
  wwi_supplier_id int not null,
  supplier string not null,
  category string not null,
  primary_contact string not null,
  supplier_reference string,
  payment_days int not null,
  postal_code string not null,
  valid_from timestamp not null,
  valid_to timestamp not null,
  lineage_key bigint not null,
	primary key(supplier_key)
);

vacuum wwi_dim.dim_supplier retain 0 hours;

drop table if exists wwi_dim.dim_transaction_type;
create table wwi_dim.dim_transaction_type
(
	transaction_type_key bigint generated always as identity,
	wwi_transaction_type_id int not null,
	transaction_type string not null,
	valid_from timestamp not null,
	valid_to timestamp not null,
	lineage_key bigint not null,
	primary key(transaction_type_key)
);

vacuum wwi_dim.dim_transaction_type retain 0 hours;