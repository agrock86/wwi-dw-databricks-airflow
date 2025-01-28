param name string
param location string
param tagsByResource object

resource name_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: name
  location: location
  properties: {}
  tags: (contains(tagsByResource, 'Microsoft.ManagedIdentity/userAssignedIdentities')
    ? tagsByResource['Microsoft.ManagedIdentity/userAssignedIdentities']
    : json('{}'))
}
