param (
    [Parameter(Mandatory=$true)]
    [string]$project,
    [Parameter(Mandatory=$true)]
    [string]$env,
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

if (-not (Get-Module -ListAvailable -Name SQLServer)) {
    Install-Module -Name SQLServer -Force -AllowClobber -Scope CurrentUser
}

# Required to use Invoke-SqlCmd.
Import-Module SQLServer

# $storage_uri = "https://${backup_storage_account}.blob.core.windows.net/${project}/${db_name}.bacpac"
$storage_uri = "https://${backup_storage_account}.blob.core.windows.net/wwi-migration/${db_name}.bacpac" # TO-DO: disable public access and restore via private endpoint.
$resource_group_name = "${project}-rg-${env}"
$etl_login = 'etl_app'

# TO-DO: check if DB already exists before trying to create it.
New-AzSqlDatabaseImport -ResourceGroupName $resource_group_name `
    -ServerName $server_name `
    -DatabaseName $db_name `
    -DatabaseMaxSizeBytes 32GB `
    -StorageKeyType "StorageAccessKey" `
    -StorageKey $(Get-AzStorageAccountKey -ResourceGroupName "common-rg-${env}" -StorageAccountName $backup_storage_account).Value[0] `
    -StorageUri $storage_uri `
    -Edition "Free" `
    -ServiceObjectiveName "GP_S_Gen5" `
    -AdministratorLogin $admin_login `
    -AdministratorLoginPassword $(ConvertTo-SecureString -String $admin_password -AsPlainText -Force)

# TO-DO: check login already exists before trying to create it.
# Create SQL login for the ETL app.
$sql_command = @"
USE master;
GO

CREATE LOGIN ${etl_login} WITH PASSWORD = '$admin_password';
GO

USE ${db_name};
GO

CREATE USER ${etl_login} FOR LOGIN ${etl_login};
GO

ALTER ROLE db_datareader ADD MEMBER ${etl_login};
"@

Invoke-SqlCmd -ServerInstance "$server_name.database.windows.net" -Database $db_name -Username $admin_login -Password $admin_password -Query $sql_command