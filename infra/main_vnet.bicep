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
    subnets: [
      // subnets must be defined here to enforce sequential creation order; otherwise it will error out.
      {
        name: '${project}-snet-data-${env}'
        properties: {
          addressPrefix: '10.0.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: [
            {
              locations: [
                default_location
              ]
              service: 'Microsoft.Storage'
            }
          ]
        }
      }
      {
        name: '${project}-snet-adb-private-${env}'
        properties: {
          addressPrefix: '10.179.0.0/18'
          delegations: [
            {
              name: '${project}-snetdel-adb-private-${env}'
              properties: {
                serviceName: 'Microsoft.Databricks/workspaces'
              }
              type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
            }
          ]
          networkSecurityGroup: {
            id: nseg_adb.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: [
            {
              locations: [
                default_location
              ]
              service: 'Microsoft.Storage'
            }
          ]
        }
      }
      {
        name: '${project}-snet-adb-public-${env}'
        properties: {
          addressPrefix: '10.179.64.0/18'
          delegations: [
            {
              name: '${project}-snetdel-adb-public-${env}'
              properties: {
                serviceName: 'Microsoft.Databricks/workspaces'
              }
              type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
            }
          ]
          networkSecurityGroup: {
            id: nseg_adb.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: [
            {
              locations: [
                default_location
              ]
              service: 'Microsoft.Storage'
            }
          ]
        }
      }
    ]
  }
}

resource nseg_adb 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: default_location
  name: '${project}-nseg-adb-${env}'
  properties: {}

  resource nsegrul_adb_worker_inbound 'securityRules' = {
    name: 'WorkerToWorkerInbound'
    properties: {
      access: 'Allow'
      description: 'Required for worker nodes communication within a cluster.'
      destinationAddressPrefix: 'VirtualNetwork'
      destinationAddressPrefixes: []
      destinationPortRange: '*'
      destinationPortRanges: []
      direction: 'Inbound'
      priority: 100
      protocol: '*'
      sourceAddressPrefix: 'VirtualNetwork'
      sourceAddressPrefixes: []
      sourcePortRange: '*'
      sourcePortRanges: []
    }
  }

  resource nsegrul_adb_plane_ssh 'securityRules' = {
    name: 'ControlPlaneToWorkerSsh'
    properties: {
      access: 'Allow'
      description: 'Required for Databricks control plane management of worker nodes.'
      destinationAddressPrefix: 'VirtualNetwork'
      destinationAddressPrefixes: []
      destinationPortRange: '22'
      destinationPortRanges: []
      direction: 'Inbound'
      priority: 101
      protocol: 'tcp'
      sourceAddressPrefix: 'AzureDatabricks'
      sourceAddressPrefixes: []
      sourcePortRange: '*'
      sourcePortRanges: []
    }
  }

  resource nsegrul_adb_plane_worker 'securityRules' = {
    name: 'ControlPlaneToWorkerProxy'
    properties: {
      access: 'Allow'
      description: 'Required for Databricks control plane communication with worker nodes.'
      destinationAddressPrefix: 'VirtualNetwork'
      destinationAddressPrefixes: []
      destinationPortRange: '5557'
      destinationPortRanges: []
      direction: 'Inbound'
      priority: 102
      protocol: 'tcp'
      sourceAddressPrefix: 'AzureDatabricks'
      sourceAddressPrefixes: []
      sourcePortRange: '*'
      sourcePortRanges: []
    }
  }

  resource nsegrul_adb_worker_outbound 'securityRules' = {
    name: 'WorkerToWorkerOutbound'
    properties: {
      access: 'Allow'
      description: 'Required for worker nodes communication within a cluster.'
      destinationAddressPrefix: 'VirtualNetwork'
      destinationAddressPrefixes: []
      destinationPortRange: '*'
      destinationPortRanges: []
      direction: 'Outbound'
      priority: 100
      protocol: '*'
      sourceAddressPrefix: 'VirtualNetwork'
      sourceAddressPrefixes: []
      sourcePortRange: '*'
      sourcePortRanges: []
    }
  }

  resource nsegrul_adb_worker_plane 'securityRules' = {
    name: 'WorkerToControlPlane'
    properties: {
      access: 'Allow'
      description: 'Required for workers communication with Databricks control plane.'
      destinationAddressPrefix: 'AzureDatabricks'
      destinationAddressPrefixes: []
      destinationPortRange: '443'
      destinationPortRanges: []
      direction: 'Outbound'
      priority: 101
      protocol: 'tcp'
      sourceAddressPrefix: 'VirtualNetwork'
      sourceAddressPrefixes: []
      sourcePortRange: '*'
      sourcePortRanges: []
    }
  }

  resource nsegrul_adb_worker_sql 'securityRules' = {
    name: 'WorkerToSql'
    properties: {
      access: 'Allow'
      description: 'Required for workers communication with Azure SQL services.'
      destinationAddressPrefix: 'Sql'
      destinationAddressPrefixes: []
      destinationPortRange: '3306'
      destinationPortRanges: []
      direction: 'Outbound'
      priority: 102
      protocol: 'tcp'
      sourceAddressPrefix: 'VirtualNetwork'
      sourceAddressPrefixes: []
      sourcePortRange: '*'
      sourcePortRanges: []
    }
  }

  resource nsegrul_adb_worker_adsl 'securityRules' = {
    name: 'WorkerToAdsl'
    properties: {
      access: 'Allow'
      description: 'Required for workers communication with Azure Storage services.'
      destinationAddressPrefix: 'Storage'
      destinationAddressPrefixes: []
      destinationPortRange: '443'
      destinationPortRanges: []
      direction: 'Outbound'
      priority: 103
      protocol: 'tcp'
      sourceAddressPrefix: 'VirtualNetwork'
      sourceAddressPrefixes: []
      sourcePortRange: '*'
      sourcePortRanges: []
    }
  }

  resource nsegrul_adb_worker_ehub 'securityRules' = {
    name: 'WorkerToEventHub'
    properties: {
      access: 'Allow'
      description: 'Required for worker communication with Azure Eventhub services.'
      destinationAddressPrefix: 'EventHub'
      destinationAddressPrefixes: []
      destinationPortRange: '9093'
      destinationPortRanges: []
      direction: 'Outbound'
      priority: 104
      protocol: 'tcp'
      sourceAddressPrefix: 'VirtualNetwork'
      sourceAddressPrefixes: []
      sourcePortRange: '*'
      sourcePortRanges: []
    }
  }
}

output vnet_main object = {
  id: vnet_main.id
  name: vnet_main.name
}

output snet_data object = {
  id: vnet_main.properties.subnets[0].id
  name: vnet_main.properties.subnets[0].name
}
