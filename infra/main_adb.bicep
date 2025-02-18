param project string
param env string
param vnet_main object

var default_location = resourceGroup().location

resource _vnet_main 'Microsoft.Network/virtualNetworks@2024-01-01' existing = {
  name: vnet_main.name
}

resource nseg_adb_main 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: default_location
  name: '${project}-nseg-adb-main-${env}'
  properties: {}

  resource nsegrul_adb_main_worker_inbound 'securityRules' = {
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

  resource nsegrul_adb_main_plane_ssh 'securityRules' = {
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

  resource nsegrul_adb_main_plane_worker 'securityRules' = {
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

  resource nsegrul_adb_main_worker_outbound 'securityRules' = {
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

  resource nsegrul_adb_main_worker_plane 'securityRules' = {
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

  resource nsegrul_adb_main_worker_sql 'securityRules' = {
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

  resource nsegrul_adb_main_worker_adsl 'securityRules' = {
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

  resource nsegrul_adb_main_worker_ehub 'securityRules' = {
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

resource snet_adb_main_private 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${project}-snet-adb-main-private-${env}'
  parent: _vnet_main
  properties: {
    addressPrefix: '10.179.0.0/18'
    delegations: [
      {
        name: '${project}-snetdel-adb-main-private-${env}'
        properties: {
          serviceName: 'Microsoft.Databricks/workspaces'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
      }
    ]
    networkSecurityGroup: {
      id: nseg_adb_main.id
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

resource snet_adb_main_public 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${project}-snet-adb-main-public-${env}'
  parent: _vnet_main
  properties: {
    addressPrefix: '10.179.64.0/18'
    delegations: [
      {
        name: '${project}-snetdel-adb-main-public-${env}'
        properties: {
          serviceName: 'Microsoft.Databricks/workspaces'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
      }
    ]
    networkSecurityGroup: {
      id: nseg_adb_main.id
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

resource adb_main 'Microsoft.Databricks/workspaces@2024-05-01' = {
  location: default_location
  name: '${project}-adb-main-${env}'
  sku: {
    name: 'premium'
  }
  properties: {
    createdBy: {}
    defaultCatalog: {
      initialType: 'UnityCatalog'
    }
    managedResourceGroupId: subscriptionResourceId('Microsoft.Resources/resourceGroups', '${project}-rg-adb-main-${env}')
    parameters: {
      customPrivateSubnetName: {
        value: snet_adb_main_private.name
      }
      customPublicSubnetName: {
        value: snet_adb_main_public.name
      }
      customVirtualNetworkId: {
        value: vnet_main.id
      }
      enableNoPublicIp: {
        value: false
      }
    }
    publicNetworkAccess: 'Enabled'
    requiredNsgRules: 'AllRules'
  }
}
