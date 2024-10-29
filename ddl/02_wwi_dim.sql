use catalog wide_world_importers_dw;

create schema if not exists wwi_dw;

use schema wwi_dw;

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
  lineage_key bigint not null
);

drop table if exists wwi_dim.dim_customer;
create table wwi_dim.dim_customer(
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
	lineage_key bigint not null
);

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
	lineage_key bigint not null
);

drop table if exists wwi_dim.dim_payment_method;
create table wwi_dim.dim_payment_method
(
	payment_method_key bigint not null generated always as identity,
	wwi_payment_method_id int not null,
	payment_method string not null,
	valid_from timestamp not null,
	valid_to timestamp not null,
	lineage_key int not null
);



