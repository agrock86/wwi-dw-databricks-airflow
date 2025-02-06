param project string
param env string
param admin_login string
@secure()
param admin_password string
param sqlsrv_wwi_oltp_name string
param sqldb_wwi_oltp_name string

var default_location = resourceGroup().location
var backup_storage_account = 'common270f06estbackup${env}'

resource uami_admin 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' existing = {
  name: '${project}-uami-admin-${env}'
}

resource dplys_wwi_oltp_restore 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: '${project}-dplys-wwi-oltp-restore-${env}'
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
    scriptContent: loadTextContent('./oltp_restore.ps1')
    arguments: '-project ${project} -env ${env} -server_name ${sqlsrv_wwi_oltp_name} -db_name ${sqldb_wwi_oltp_name} -admin_login ${admin_login} -admin_password ${admin_password} -backup_storage_account "${backup_storage_account}"'
  }
}
