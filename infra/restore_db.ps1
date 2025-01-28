param (
    [Parameter(Mandatory=$true)]
    [string]$project,
    [Parameter(Mandatory=$true)]
    [string]$environment,
    [Parameter(Mandatory=$true)]
    [string]$server_name,
    [Parameter(Mandatory=$true)]
    [string]$db_name,
    [Parameter(Mandatory=$true)]
    [string]$admin_login,
    [Parameter(Mandatory=$true)]
    # There is no way to pass a secure string parameter from bicep, so a normal string is used.
    [string]$admin_password,
    [Parameter(Mandatory=$true)]
    [string]$backup_storage_account
)
# $storage_uri = "https://${backup_storage_account}.blob.core.windows.net/${project}/${db_name}.bacpac"
$storage_uri = "https://${backup_storage_account}.blob.core.windows.net/wwi-migration/${db_name}.bacpac"
$resource_group_name = "${project}-rg-${environment}"

$import_request = New-AzSqlDatabaseImport -ResourceGroupName $resource_group_name `
    -ServerName $server_name `
    -DatabaseName $db_name `
    -DatabaseMaxSizeBytes 32GB `
    -StorageKeyType "StorageAccessKey" `
    -StorageKey $(Get-AzStorageAccountKey -ResourceGroupName "common-rg-${environment}" -StorageAccountName $backup_storage_account).Value[0] `
    -StorageUri $storage_uri `
    -Edition "Free" `
    -ServiceObjectiveName "GP_S_Gen5" `
    -AdministratorLogin $admin_login `
    -AdministratorLoginPassword $(ConvertTo-SecureString -String $admin_password -AsPlainText -Force)