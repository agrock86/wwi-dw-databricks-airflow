targetScope = 'subscription'

param deployment_id string
param default_location string
param project string
param env string
@secure()
param admin_password string
param client_ip string

var admin_login = 'sys_admin'

// common resource group with shared resources.
resource rg_common 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: 'common-rg-${env}'
}

// project resource group.
resource rg_main 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${project}-rg-${env}'
  location: default_location
}

module resource_group_module 'resource_group.bicep' = {
  name: '${project}-dply-resource-group-${deployment_id}-${env}'
  scope: rg_main
  params: {
    project: project
    env: env
  }
}

// configures the common resource group with project scoped resources.
module common_resource_group_module 'common_resource_group.bicep' = {
  name: '${project}-dply-common-resource-group-${deployment_id}-${env}'
  scope: rg_common
  params: {
    project: project
    env: env
  }
  dependsOn: [
    rg_main
  ]
}

module network_module './network.bicep' = {
  name: '${project}-dply-network-${deployment_id}-${env}'
  scope: rg_main
  params: {
    project: project
    env: env
  }
}

module db_module './db.bicep' = {
  name: '${project}-dply-db-${deployment_id}-${env}'
  scope: rg_main
  params: {
    project: project
    env: env
    admin_login: admin_login
    admin_password: admin_password
    client_ip: client_ip
  }
}

module vm_module './vm.bicep' = {
  name: '${project}-dply-vm-${deployment_id}-${env}'
  scope: rg_main
  params: {
    project: project
    env: env
    admin_login: admin_login
    admin_password: admin_password
  }
  dependsOn: [
    network_module
  ]
}

// configures the common backup storage with project scoped resources.
module common_backup_storage_module 'common_backup_storage.bicep' = {
  name: '${project}-dply-common-backup-storage-${deployment_id}-${env}'
  scope: rg_common
  params: {
    project: project
    project_tenant_id: tenant().tenantId
    env: env
    access_rules_resource_ids: array(db_module.outputs.sqlsrv_wwi_oltp_id)
    client_ip: client_ip
  }
}

//TO-DO: make the Azure SQL Server private after deployment
