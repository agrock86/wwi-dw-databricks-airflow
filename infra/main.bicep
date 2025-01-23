targetScope = 'subscription'

param default_location string
param deployment_id string
param project string
param environment string

resource rg_main 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${project}-rg-main-${environment}'
  location: default_location
}

module network_module './network.bicep' = {
  name: '${project}-dply-${deployment_id}-${environment}'
  scope: rg_main
  params: {
    project: project
    environment: environment
  }
}
