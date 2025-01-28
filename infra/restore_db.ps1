# TO-DO: add parameter project and remove hardcoded 'wwi-migration' value.
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
    [string]$admin_password,
    [Parameter(Mandatory=$true)]
    [string]$backup_storage_account
)
$storage_uri = 'https://$backup_storage_account.blob.core.windows.net/$project/$db.bacpac'

$import_request = New-AzSqlDatabaseImport -ResourceGroupName $resource_group_name `
    -ServerName $server_name `
    -DatabaseName $db_name `
    -DatabaseMaxSizeBytes 32GB `
    -StorageKeyType "StorageAccessKey" `
    -StorageKey $(Get-AzStorageAccountKey -ResourceGroupName "common-rg-dev" -StorageAccountName $backup_storage_account).Value[0] `
    -StorageUri $storage_uri `
    -Edition "Free" `
    -ServiceObjectiveName "GP_S_Gen5" `
    -AdministratorLogin $admin_login `
    -AdministratorLoginPassword $(ConvertTo-SecureString -String $admin_password -AsPlainText -Force)

# Check import status and wait for the import to complete
$import_status = Get-AzSqlDatabaseImportExportStatus -OperationStatusLink $import_request.OperationStatusLink
[Console]::Write("Importing")
while ($import_status.Status -eq "InProgress")
{
    $import_status = Get-AzSqlDatabaseImportExportStatus -OperationStatusLink $import_request.OperationStatusLink
    [Console]::Write(".")
    Start-Sleep -s 10
}
[Console]::WriteLine("")
$import_status