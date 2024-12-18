-- drop external location if exists wwi_migration_adls_dev;

-- create external location wwi_migration_adls_dev
-- url 'abfss://dwh@wwimigrstdevagrock86.dfs.core.windows.net'
-- with (storage credential wwi_migration_sp_adls_dev);

drop catalog if exists wide_world_importers_dw;

create catalog wide_world_importers_dw
-- managed location 'abfss://dwh@wwimigrstdevagrock86.dfs.core.windows.net';

-- grant create external location on storage credential wwi_migration_sp_adls_dev to administrators;
-- grant create external table on external location wwi_migration_adls_dev to administrators;
-- grant all privileges on external location wwi_migration_adls_dev to administrators;