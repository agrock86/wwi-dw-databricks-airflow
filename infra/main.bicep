targetScope = 'subscription'

param deployment_id string
param default_location string
param project string
param env string
@secure()
param admin_password string
param client_ip string

var admin_login = 'sys_admin'

resource rg_common 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: 'common-rg-${env}'
}

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

module resource_group_common_module 'resource_group_common.bicep' = {
  name: '${project}-dply-resource-group-common-${deployment_id}-${env}'
  scope: rg_common
  params: {
    project: project
    env: env
  }
  dependsOn: [
    resource_group_module
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

//TO-DO: make the Azure SQL Server private after deployment
