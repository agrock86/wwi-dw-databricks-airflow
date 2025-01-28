targetScope = 'subscription'

param default_location string
param deployment_id string
param project string
param environment string
@secure()
param admin_password string

resource rg_common 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: 'common-rg-${environment}'
}

resource rg_main 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${project}-rg-main-${environment}'
  location: default_location
}

module resource_group_module 'resource_group.bicep' = {
  name: '${project}-dply-resource-group-${deployment_id}-${environment}'
  scope: rg_main
  params: {
    project: project
    environment: environment
  }
}

module resource_group_common_module 'resource_group_common.bicep' = {
  name: '${project}-dply-resource-group-common-${deployment_id}-${environment}'
  scope: rg_common
  params: {
    project: project
    environment: environment
  }
  dependsOn: [
    resource_group_module
  ]
}

module network_module './network.bicep' = {
  name: '${project}-dply-network-${deployment_id}-${environment}'
  scope: rg_main
  params: {
    project: project
    environment: environment
  }
}

// module db_module './db.bicep' = {
//   name: '${project}-dply-db-${deployment_id}-${environment}'
//   scope: rg_main
//   params: {
//     project: project
//     environment: environment
//     admin_password: admin_password
//   }
// }
