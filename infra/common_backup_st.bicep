param env string
param public_network_access string

var default_location = resourceGroup().location

resource st_backup 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'common270f06estbackup${env}'
  location: default_location
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    accessTier: 'Cold'
    publicNetworkAccess: public_network_access
    allowCrossTenantReplication: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    dnsEndpointType: 'Standard'
    largeFileSharesState: 'Enabled'
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        blob: {
          enabled: true
        }
        file: {
          enabled: true
        }
        table: {
          enabled: true
        }
        queue: {
          enabled: true
        }
      }
      requireInfrastructureEncryption: false
    }
  }
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: {}
}

resource blobs_backup 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: st_backup
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource files_backup 'Microsoft.Storage/storageAccounts/fileservices@2023-05-01' = {
  parent: st_backup
  name: 'default'
  properties: {
    protocolSettings: null
    shareDeleteRetentionPolicy: {
      enabled: false
    }
  }
}

resource blob_backup 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: blobs_backup
  name: 'wwi-migration'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
}

output st_backup object = {
  id: st_backup.id
  name: st_backup.name
}
