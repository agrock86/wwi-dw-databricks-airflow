param project string
param env string
param admin_login string
@secure()
param admin_password string
param sqlsrv_wwi_oltp object
param sqldb_wwi_oltp object
param uami_admin object
param st_backup object

var default_location = resourceGroup().location

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
    arguments: '-project ${project} -env ${env} -server_name ${sqlsrv_wwi_oltp.name} -db_name ${sqldb_wwi_oltp.name} -admin_login ${admin_login} -admin_password ${admin_password} -backup_storage_account "${st_backup.name}"'
  }
}
