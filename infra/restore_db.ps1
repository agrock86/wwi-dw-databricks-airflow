param (
    [Parameter(Mandatory=$true)]
    [string]$resource_group_name,
    [Parameter(Mandatory=$true)]
    [string]$server_name,
    [Parameter(Mandatory=$true)]
    [string]$admin_login,
    [Parameter(Mandatory=$true)]
    [SecureString]$admin_password,
    [Parameter(Mandatory=$true)]
    [string]$storage_account_name
)
$db_name = 'WideWorldImporters'
$storage_uri = 'https://$storage_account_name.blob.core.windows.net/wwi-migration/WideWorldImporters.bacpac'

Import-AzSqlDatabase `
-ResourceGroupName $resource_group_name `
-ServerName $server_name `
-DatabaseName $db_name `
-StorageKeyType StorageAccessKey `
-StorageUri $storage_uri `
-AuthenticationType Sql `
-SqlAdministratorCredentials (New-Object System.Management.Automation.PSCredential($admin_login, (ConvertTo-SecureString $admin_password -AsPlainText -Force)))

# $importRequest = New-AzSqlDatabaseImport -ResourceGroupName $resource_group_name `
#     -ServerName $server_name `
#     -DatabaseName $db_name `
#     -DatabaseMaxSizeBytes 32GB `
#     -StorageKeyType "StorageAccessKey" `
#     -StorageKey $(Get-AzStorageAccountKey -ResourceGroupName $resource_group_name -StorageAccountName $storage_account_name).Value[0] `
#     -StorageUri $storage_uri -Edition "Free" -ServiceObjectiveName "P6" -AdministratorLogin "<userId>" -AdministratorLoginPassword $(ConvertTo-SecureString -String "<password>" -AsPlainText -Force)