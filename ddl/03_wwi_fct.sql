use catalog wide_world_importers_dw;

create schema if not exists wwi_dw;

use schema wwi_fct;

drop table if exists wwi_fct.fct_movement;
create table wwi_fct.fct_movement
(
    date_key date not null,
    stock_item_key int not null,
    customer_key int,
    supplier_key int,
    transaction_type_key int not null,
    wwi_stock_item_transaction_id int not null,
    wwi_invoice_id int,
    wwi_purchase_order_id int,
    quantity int not null,
    lineage_key bigint not null
) partitioned by (date_key);

drop table if exists wwi_fct.fct_order;
create table wwi_fct.fct_order
(
    city_key bigint not null,
    customer_key bigint not null,
    stock_item_key bigint not null,
    order_date_key date not null,
    picked_date_key date,
    salesperson_key bigint not null,
    picker_key bigint,
    wwi_order_id int not null,
    wwi_backorder_id int,
    description string not null,
    package string not null,
    quantity int not null,
    unit_price decimal(18, 2) not null,
    tax_rate decimal(18, 3) not null,
    total_excluding_tax decimal(18, 2) not null,
    tax_amount decimal(18, 2) not null,
    total_including_tax decimal(18, 2) not null,
    lineage_key bigint not null
)
partitioned by (order_date_key);

drop table if exists wwi_fct.fct_purchase;

create table wwi_fct.fct_purchase (
    purchase_key bigint generated always as identity,
    date_key date not null,
    supplier_key bigint not null,
    stock_item_key bigint not null,
    wwi_purchase_order_id int,
    ordered_outers int not null,
    ordered_quantity int not null,
    received_outers int not null,
    package string not null,
    is_order_finalized boolean not null,
    lineage_key bigint not null
)
partitioned by (date_key);


