param uami_admin object

// defined for the common resource group.
resource rlea_common_admin 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, uami_admin.principal_id, 'Contributor')
  properties: {
    principalId: uami_admin.principal_id
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  }
}
