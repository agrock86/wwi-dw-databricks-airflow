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


