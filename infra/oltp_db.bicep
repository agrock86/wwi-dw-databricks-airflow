param project string
param env string
param admin_login string
@secure()
param admin_password string
param client_ip string

var default_location = resourceGroup().location

resource sqlsrv_wwi_oltp 'Microsoft.Sql/servers@2023-08-01-preview' = {
  location: default_location
  name: '${project}-sqlsrv-wwi-oltp-${env}'
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
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

resource fiwr_wwi_oltp_client 'Microsoft.Sql/servers/firewallRules@2024-05-01-preview' = {
  parent: sqlsrv_wwi_oltp
  name: 'ClientIPAddress'
  properties: {
    startIpAddress: client_ip
    endIpAddress: client_ip
  }
}

resource fiwr_wwi_oltp_azure 'Microsoft.Sql/servers/firewallRules@2024-05-01-preview' = {
  parent: sqlsrv_wwi_oltp
  name: 'AllowAllWindowsAzureIps'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource sqldb_wwi_oltp 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  parent: sqlsrv_wwi_oltp
  location: default_location
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

output sqlsrv_wwi_oltp object = {
  id: sqlsrv_wwi_oltp.id
  name: sqlsrv_wwi_oltp.name
}

output sqldb_wwi_oltp object = {
  id: sqldb_wwi_oltp.id
  name: sqldb_wwi_oltp.name
}
