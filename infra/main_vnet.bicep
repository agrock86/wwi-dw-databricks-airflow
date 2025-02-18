param project string
param env string

var default_location = resourceGroup().location

resource vnet_main 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  location: default_location
  name: '${project}-vnet-main-${env}'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
        '10.1.0.0/16'
        '10.179.0.0/16'
      ]
    }
    enableDdosProtection: false
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    // subnets: [
    //   // subnets must be defined here to enforce sequential creation order; otherwise it will error out.
    //   {
    //     name: '${project}-snet-data-${env}'
    //     properties: {
    //       addressPrefix: '10.0.0.0/24'
    //       delegations: []
    //       privateEndpointNetworkPolicies: 'Disabled'
    //       privateLinkServiceNetworkPolicies: 'Enabled'
    //       serviceEndpoints: [
    //         {
    //           locations: [
    //             default_location
    //           ]
    //           service: 'Microsoft.Storage'
    //         }
    //       ]
    //     }
    //   }
    // ]
  }
}

output vnet_main object = {
  id: vnet_main.id
  name: vnet_main.name
}
