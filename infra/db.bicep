param project string
param environment string
@secure()
param admin_password string

var default_location = resourceGroup().location
var admin_login = 'sysadmin'
var backup_storage_account_name = 'commonstbackup270f06edev'

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
      principalType: 'User' // TO-DO: change to admins group
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

resource dplys_wwi_oltp 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'RestoreScript'
  location: default_location
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}': {}
    }
  }
  properties: {
    azPowerShellVersion: '7.2'
    retentionInterval: 'PT1H'
    forceUpdateTag: '1'
    scriptContent: loadTextContent('restore_db.ps1') // Load script content from file
    arguments: '-resource_group_name ${resourceGroup().name} -server_name ${sqlsrv_wwi_oltp.name} -admin_login ${admin_login} -admin_password ${admin_password} -storage_account_name ${backup_storage_account_name}' // Pass arguments to the script
  }
}

// resource sqlsrvthpro_wwi_oltp 'Microsoft.Sql/servers/advancedThreatProtectionSettings@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'Default'
//   properties: {
//     state: 'Disabled'
//   }
// }

// resource sqlsrvadvs_wwi_oltp_idx_create 'Microsoft.Sql/servers/advisors@2014-04-01' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'CreateIndex'
//   properties: {
//     autoExecuteValue: 'Disabled'
//   }
// }

// resource sqlsrvadvs_wwi_oltp_db_param 'Microsoft.Sql/servers/advisors@2014-04-01' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'DbParameterization'
//   properties: {
//     autoExecuteValue: 'Disabled'
//   }
// }

// resource sqlsrvadvs_wwi_oltp_idx_defrag 'Microsoft.Sql/servers/advisors@2014-04-01' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'DefragmentIndex'
//   properties: {
//     autoExecuteValue: 'Disabled'
//   }
// }

// resource sqlsrvadvs_wwi_oltp_idx_drop 'Microsoft.Sql/servers/advisors@2014-04-01' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'DropIndex'
//   properties: {
//     autoExecuteValue: 'Disabled'
//   }
// }

// resource sqlsrvadvs_wwi_oltp_last_plan 'Microsoft.Sql/servers/advisors@2014-04-01' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'ForceLastGoodPlan'
//   properties: {
//     autoExecuteValue: 'Enabled'
//   }
// }

// resource sqlsrvaudp_wwi_oltp 'Microsoft.Sql/servers/auditingPolicies@2014-04-01' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'Default'
//   properties: {
//     auditingState: 'Disabled'
//   }
// }

// resource sqlsrvauds_wwi_oltp 'Microsoft.Sql/servers/auditingSettings@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'default'
//   properties: {
//     auditActionsAndGroups: []
//     isAzureMonitorTargetEnabled: false
//     isManagedIdentityInUse: false
//     isStorageSecondaryKeyInUse: false
//     retentionDays: 0
//     state: 'Disabled'
//     storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
//   }
// }

// resource sqlsrvadaut_wwi_oltp 'Microsoft.Sql/servers/azureADOnlyAuthentications@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'Default'
//   properties: {
//     azureADOnlyAuthentication: false
//   }
// }

// resource sqlsrvconnp_wwi_oltp 'Microsoft.Sql/servers/connectionPolicies@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'default'
//   properties: {
//     connectionType: 'Default'
//   }
// }

// resource sqlsrvdoauds_wwi_oltp 'Microsoft.Sql/servers/devOpsAuditingSettings@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'Default'
//   properties: {
//     isAzureMonitorTargetEnabled: false
//     isManagedIdentityInUse: false
//     state: 'Disabled'
//     storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
//   }
// }

// resource sqlsrvencpro_wwi_oltp 'Microsoft.Sql/servers/encryptionProtector@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'current'
//   properties: {
//     autoRotationEnabled: false
//     serverKeyName: 'ServiceManaged'
//     serverKeyType: 'ServiceManaged'
//   }
// }

// resource sqlsrveauds_wwi_oltp 'Microsoft.Sql/servers/extendedAuditingSettings@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'default'
//   properties: {
//     auditActionsAndGroups: []
//     isAzureMonitorTargetEnabled: false
//     isManagedIdentityInUse: false
//     isStorageSecondaryKeyInUse: false
//     retentionDays: 0
//     state: 'Disabled'
//     storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
//   }
// }

// resource sqldbthpro_wwi_master 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2023-08-01-preview' = {
//   name: '${sqlsrv_wwi_oltp.name}/master/Default'
//   properties: {
//     state: 'Disabled'
//   }
// }

// resource sqldbaudp_wwi_master 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
//   name: '${sqlsrv_wwi_oltp.name}/master/Default'
//   properties: {
//     auditingState: 'Disabled'
//   }
// }

// resource sqldbauds_wwi_master 'Microsoft.Sql/servers/databases/auditingSettings@2023-08-01-preview' = {
//   name: '${sqlsrv_wwi_oltp.name}/master/Default'
//   properties: {
//     isAzureMonitorTargetEnabled: false
//     retentionDays: 0
//     state: 'Disabled'
//     storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
//   }
// }

// resource sqldbeauds_wwi_master 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2023-08-01-preview' = {
//   name: '${sqlsrv_wwi_oltp.name}/master/Default'
//   properties: {
//     isAzureMonitorTargetEnabled: false
//     retentionDays: 0
//     state: 'Disabled'
//     storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
//   }
// }

// resource sqldbgeobkp_wwi_master 'Microsoft.Sql/servers/databases/geoBackupPolicies@2023-08-01-preview' = {
//   name: '${sqlsrv_wwi_oltp.name}/master/Default'
//   properties: {
//     state: 'Disabled'
//   }
// }

// resource sqldbledup_wwi_master 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2023-08-01-preview' = {
//   name: '${sqlsrv_wwi_oltp.name}/master/Current'
//   properties: {}
// }

// resource sqldbsecap_wwi_master 'Microsoft.Sql/servers/databases/securityAlertPolicies@2023-08-01-preview' = {
//   name: '${sqlsrv_wwi_oltp.name}/master/Default'
//   properties: {
//     disabledAlerts: [
//       ''
//     ]
//     emailAccountAdmins: false
//     emailAddresses: [
//       ''
//     ]
//     retentionDays: 0
//     state: 'Disabled'
//   }
// }

// resource sqldbtde_wwi_master 'Microsoft.Sql/servers/databases/transparentDataEncryption@2023-08-01-preview' = {
//   name: '${sqlsrv_wwi_oltp.name}/master/Current'
//   properties: {
//     state: 'Disabled'
//   }
// }

// resource sqldbvulnas_wwi_master 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2023-08-01-preview' = {
//   name: '${sqlsrv_wwi_oltp.name}/master/Default'
//   properties: {
//     recurringScans: {
//       emailSubscriptionAdmins: true
//       isEnabled: false
//     }
//   }
// }

// resource sqlsrvfirul_wwi_oltp_azure 'Microsoft.Sql/servers/firewallRules@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'AllowAllWindowsAzureIps'
//   properties: {
//     endIpAddress: '0.0.0.0'
//     startIpAddress: '0.0.0.0'
//   }
// }

// resource sqlsrvfirul_wwi_oltp_client 'Microsoft.Sql/servers/firewallRules@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'ClientIPAddress'
//   properties: {
//     endIpAddress: local_ip
//     startIpAddress: local_ip
//   }
// }

// resource sqlsrvkey_wwi_oltp 'Microsoft.Sql/servers/keys@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'ServiceManaged'
//   properties: {
//     serverKeyType: 'ServiceManaged'
//   }
// }

// resource sqlsrvsecap_wwi_oltp 'Microsoft.Sql/servers/securityAlertPolicies@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'Default'
//   properties: {
//     disabledAlerts: [
//       ''
//     ]
//     emailAccountAdmins: false
//     emailAddresses: [
//       ''
//     ]
//     retentionDays: 0
//     state: 'Disabled'
//   }
// }

// resource sqlsrvsqlvulnas_wwi_oltp 'Microsoft.Sql/servers/sqlVulnerabilityAssessments@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'Default'
//   properties: {
//     state: 'Disabled'
//   }
// }

// resource sqlsrvvulnas_wwi_oltp 'Microsoft.Sql/servers/vulnerabilityAssessments@2023-08-01-preview' = {
//   parent: sqlsrv_wwi_oltp
//   name: 'Default'
//   properties: {
//     recurringScans: {
//       emailSubscriptionAdmins: true
//       isEnabled: false
//     }
//     storageContainerPath: vulnerabilityAssessments_Default_storageContainerPath
//   }
// }

// resource sqldbthpro_wwi_oltp 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2023-08-01-preview' = {
//   parent: 
//   name: 'Default'
//   properties: {
//     state: 'Disabled'
//   }
// }

// resource servers_wwi_migration_agrock86_name_WideWorldImporters_CreateIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'CreateIndex'
//   properties: {
//     autoExecuteValue: 'Disabled'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource servers_wwi_migration_agrock86_name_WideWorldImporters_DbParameterization 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'DbParameterization'
//   properties: {
//     autoExecuteValue: 'Disabled'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource servers_wwi_migration_agrock86_name_WideWorldImporters_DefragmentIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'DefragmentIndex'
//   properties: {
//     autoExecuteValue: 'Disabled'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource servers_wwi_migration_agrock86_name_WideWorldImporters_DropIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'DropIndex'
//   properties: {
//     autoExecuteValue: 'Disabled'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource servers_wwi_migration_agrock86_name_WideWorldImporters_ForceLastGoodPlan 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'ForceLastGoodPlan'
//   properties: {
//     autoExecuteValue: 'Enabled'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource Microsoft_Sql_servers_databases_auditingPolicies_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   location: 'East US'
//   name: 'Default'
//   properties: {
//     auditingState: 'Disabled'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource Microsoft_Sql_servers_databases_auditingSettings_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/auditingSettings@2023-08-01-preview' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'default'
//   properties: {
//     isAzureMonitorTargetEnabled: false
//     retentionDays: 0
//     state: 'Disabled'
//     storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource Microsoft_Sql_servers_databases_backupLongTermRetentionPolicies_servers_wwi_migration_agrock86_name_WideWorldImporters_default 'Microsoft.Sql/servers/databases/backupLongTermRetentionPolicies@2023-08-01-preview' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'default'
//   properties: {
//     monthlyRetention: 'PT0S'
//     weekOfYear: 0
//     weeklyRetention: 'PT0S'
//     yearlyRetention: 'PT0S'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource Microsoft_Sql_servers_databases_backupShortTermRetentionPolicies_servers_wwi_migration_agrock86_name_WideWorldImporters_default 'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies@2023-08-01-preview' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'default'
//   properties: {
//     diffBackupIntervalInHours: 12
//     retentionDays: 7
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource Microsoft_Sql_servers_databases_extendedAuditingSettings_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2023-08-01-preview' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'default'
//   properties: {
//     isAzureMonitorTargetEnabled: false
//     retentionDays: 0
//     state: 'Disabled'
//     storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource Microsoft_Sql_servers_databases_geoBackupPolicies_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2023-08-01-preview' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'Default'
//   properties: {
//     state: 'Disabled'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource servers_wwi_migration_agrock86_name_WideWorldImporters_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2023-08-01-preview' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'Current'
//   properties: {}
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource Microsoft_Sql_servers_databases_securityAlertPolicies_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2023-08-01-preview' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'Default'
//   properties: {
//     disabledAlerts: [
//       ''
//     ]
//     emailAccountAdmins: false
//     emailAddresses: [
//       ''
//     ]
//     retentionDays: 0
//     state: 'Disabled'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource Microsoft_Sql_servers_databases_transparentDataEncryption_servers_wwi_migration_agrock86_name_WideWorldImporters_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2023-08-01-preview' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'Current'
//   properties: {
//     state: 'Enabled'
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }

// resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2023-08-01-preview' = {
//   parent: servers_wwi_migration_agrock86_name_WideWorldImporters
//   name: 'Default'
//   properties: {
//     recurringScans: {
//       emailSubscriptionAdmins: true
//       isEnabled: false
//     }
//   }
//   dependsOn: [
//     servers_wwi_migration_agrock86_name_resource
//   ]
// }
