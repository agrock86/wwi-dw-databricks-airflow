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
    # there is no way to pass a secure string parameter from bicep, so a normal string is used.
    [string]$admin_password,
    [Parameter(Mandatory=$true)]
    [string]$backup_storage_account
)

if (-not (Get-Module -ListAvailable -Name SQLServer)) {
    Install-Module -Name SQLServer -Force -AllowClobber -Scope CurrentUser
}

# required to use Invoke-SqlCmd.
Import-Module SQLServer

# $storage_uri = "https://${backup_storage_account}.blob.core.windows.net/${project}/${db_name}.bacpac"
$storage_uri = "https://${backup_storage_account}.blob.core.windows.net/wwi-migration/${db_name}.bacpac"
$resource_group_name = "${project}-rg-main-${env}"
$etl_login = "etl_app"

$import_request = New-AzSqlDatabaseImport -ResourceGroupName $resource_group_name `
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

# check restore status and wait for the import to complete.
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

$sql_command = @"
USE ${db_name};
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = '${etl_login}')
BEGIN
    DROP USER ${etl_login};
END

USE master;
GO

IF EXISTS (SELECT * FROM sys.sql_logins WHERE name = '${etl_login}')
BEGIN
    DROP LOGIN ${etl_login};
END
GO

USE master;
GO

CREATE LOGIN ${etl_login} WITH PASSWORD = '$admin_password';

USE ${db_name};
GO

CREATE USER ${etl_login} FOR LOGIN ${etl_login};
GO

ALTER ROLE db_datareader ADD MEMBER ${etl_login};
"@

Invoke-SqlCmd -ServerInstance "$server_name.database.windows.net" -Database $db_name -Username $admin_login -Password $admin_password -Query $sql_command