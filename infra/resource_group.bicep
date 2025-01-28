param project string
param environment string

var default_location = resourceGroup().location

resource uami_admin 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: '${project}-uami-admin-${environment}'
  location: default_location
}

resource rlea_admin 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, uami_admin.name, 'Contributor')
  properties: {
    principalId: uami_admin.properties.principalId
    principalType: 'ServicePrincipal' // if not set, assigment will be added before managed identity above is ready and it will error out.
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  }
}

output admin_managed_identity_id string = uami_admin.id

