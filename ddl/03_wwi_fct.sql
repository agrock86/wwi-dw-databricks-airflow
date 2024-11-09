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
create table wwi_fct.fct_purchase
(
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

drop table if exists wide_world_importers_dw.wwi_fct.fct_sale;
create table wide_world_importers_dw.wwi_fct.fct_sale
(
    city_key bigint not null,
    customer_key bigint not null,
    bill_to_customer_key bigint not null,
    stock_item_key bigint not null,
    invoice_date_key date not null,
    delivery_date_key date,
    salesperson_key bigint not null,
    wwi_invoice_id int not null,
    description string not null,
    package string not null,
    quantity int not null,
    unit_price decimal(18, 2) not null,
    tax_rate decimal(18, 3) not null,
    total_excluding_tax decimal(18, 2) not null,
    tax_amount decimal(18, 2) not null,
    profit decimal(18, 2) not null,
    total_including_tax decimal(18, 2) not null,
    total_dry_items int not null,
    total_chiller_items int not null,
    lineage_key bigint not null
)
partitioned by (invoice_date_key);

drop table if exists wide_world_importers_dw.wwi_fct.fct_stock_holding;
create table wide_world_importers_dw.wwi_fct.fct_stock_holding
(
    stock_item_key bigint not null,
    quantity_on_hand int not null,
    bin_location string not null,
    last_stocktake_quantity int not null,
    last_cost_price decimal(18, 2) not null,
    reorder_level int not null,
    target_stock_level int not null,
    lineage_key bigint not null
);

drop table if exists wide_world_importers_dw.wwi_fct.fct_transaction;
create table wide_world_importers_dw.wwi_fct.fct_transaction
(
    date_key date not null,
    customer_key bigint,
    bill_to_customer_key bigint,
    supplier_key bigint,
    transaction_type_key bigint not null,
    payment_method_key bigint,
    wwi_customer_transaction_id int,
    wwi_supplier_transaction_id int,
    wwi_invoice_id int,
    wwi_purchase_order_id int,
    supplier_invoice_number string,
    total_excluding_tax decimal(18, 2) not null,
    tax_amount decimal(18, 2) not null,
    total_including_tax decimal(18, 2) not null,
    outstanding_balance decimal(18, 2) not null,
    is_finalized boolean not null,
    lineage_key bigint not null
)
partitioned by (date_key);


