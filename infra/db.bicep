param project string
param environment string
@secure()
param admin_password string

var default_location = resourceGroup().location
var admin_login = 'sys_admin'
var backup_storage_account = 'commonstbackup270f06e${environment}'

resource uami_admin 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' existing = {
  name: '${project}-uami-admin-${environment}'
}

resource sqlsrv_wwi_oltp 'Microsoft.Sql/servers@2023-08-01-preview' = {
  location: default_location
  name: '${project}-sqlsrv-wwi-oltp-${environment}'
  properties: {
    administratorLogin: admin_login
    administratorLoginPassword: admin_password
    administrators: {
      administratorType: 'ActiveDirectory'
      azureADOnlyAuthentication: false
      login: 'azureadmin@twinsensorhotmail.onmicrosoft.com'
      principalType: 'User'
      sid: 'f0fc54ec-41b0-4b93-af4b-035fcd81e298'
      tenantId: '5f751a8a-2fcf-4979-9e68-b20f298c27ba'
    }
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Disabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

resource sqldb_wwi_oltp 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  parent: sqlsrv_wwi_oltp
  location: 'eastus'
  name: 'WideWorldImporters'
  properties: {
    autoPauseDelay: 60
    availabilityZone: 'NoPreference'
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    freeLimitExhaustionBehavior: 'AutoPause'
    isLedgerOn: false
    maxSizeBytes: 34359738368
    minCapacity: json('0.5')
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Local'
    useFreeLimit: false
    zoneRedundant: false
  }
  sku: {
    capacity: 2
    family: 'Gen5'
    name: 'GP_S_Gen5'
    tier: 'GeneralPurpose'
  }
}

  resource dplys_wwi_oltp_restore 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
    name: '${project}-dplys-wwi-oltp-restore-${environment}'
    location: default_location
    kind: 'AzurePowerShell'
    identity: {
      type: 'UserAssigned'
      userAssignedIdentities: {
        '${uami_admin.id}': {}
      }
    }
    properties: {
      azPowerShellVersion: '7.2'
      retentionInterval: 'PT1H'
      forceUpdateTag: '1'
      scriptContent: loadTextContent('./restore_db.ps1')
      arguments: '-project ${project} -environment ${environment} -server_name ${sqlsrv_wwi_oltp.name} -db_name ${sqldb_wwi_oltp.name} -admin_login ${admin_login} -admin_password ${admin_password} -backup_storage_account "${backup_storage_account}"'
    }
  }
