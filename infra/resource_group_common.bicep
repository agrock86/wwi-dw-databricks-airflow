param project string
param environment string

resource uami_admin 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' existing = {
  name: '${project}-uami-admin-${environment}'
  scope: resourceGroup('${project}-rg-main-${environment}')
}

resource rlea_common_admin 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, uami_admin.id, 'Contributor')
  properties: {
    principalId: uami_admin.properties.principalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  }
}
