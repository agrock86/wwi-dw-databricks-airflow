var project = 'wwi-migration'
var environment = 'dev'
var default_location = 'eastus'

resource vnet_data 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  location: default_location
  name: '${project}-vnet-data-${environment}'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
        '10.179.0.0/16'
      ]
    }
    enableDdosProtection: false
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    virtualNetworkPeerings: [
      {
        id: virtualNetworks_wwi_migration_vnet_dev_name_wwi_migration_vnetp_aflw_dev.id
        name: 'wwi-migration-vnetp-aflw-dev'
        properties: {
          allowForwardedTraffic: false
          allowGatewayTransit: false
          allowVirtualNetworkAccess: true
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteAddressSpace: {
            addressPrefixes: [
              '10.1.0.0/16'
            ]
          }
          remoteVirtualNetwork: {
            id: virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_resource.id
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.1.0.0/16'
            ]
          }
          useRemoteGateways: false
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
  }
}

resource snet_data 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
  name: '${project}-snet-data-${environment}'
  parent: vnet_data
  properties: {
    addressPrefix: '10.0.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpoints: [
      {
        locations: [
          default_location
          // 'westus'
          // 'westus3'
        ]
        service: 'Microsoft.Storage'
      }
    ]
  }
}

resource nseg_adb 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: default_location
  name: '${project}-nseg-adb-${environment}'
  properties: {
    securityRules: [
      {
        name: '${project}-nsegrul-adb-worker-inbound-${environment}'
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
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-adb-plane-ssh-${environment}'
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
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-adb-plane-worker-${environment}'
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
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-adb-worker-outbound-${environment}'
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
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-adb-worker-plane-${environment}'
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
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-adb-worker-sql-${environment}'
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
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-adb-worker-adsl-${environment}'
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
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-adb-worker-ehub-${environment}'
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
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
    ]
  }
}

resource snet_adb_private 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
  name: '${project}-snet-adb-private-${environment}'
  parent: vnet_data
  properties: {
    addressPrefix: '10.179.0.0/18'
    delegations: [
      {
        name: '${project}-snetdel-adb-private-${environment}'
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
          // 'westus'
          // 'westus3'
        ]
        service: 'Microsoft.Storage'
      }
    ]
  }
}

resource snet_adb_public 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
  name: '${project}-snet-adb-public-${environment}'
  parent: vnet_data
  properties: {
    addressPrefix: '10.179.64.0/18'
    delegations: [
      {
        name: '${project}-snetdel-adb-public-${environment}'
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
          // 'westus'
          // 'westus3'
        ]
        service: 'Microsoft.Storage'
      }
    ]
  }
}

resource vnet_etl 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  location: default_location
  name: '${project}-vnet-etl-${environment}'
  properties: {
    addressSpace: {
      addressPrefix: '10.1.0.0/16'
    }
    enableDdosProtection: false
    virtualNetworkPeerings: [
      {
        id: virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_wwi_migration_vnetp_dev.id
        name: 'wwi-migration-vnetp-dev'
        properties: {
          allowForwardedTraffic: false
          allowGatewayTransit: false
          allowVirtualNetworkAccess: true
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
              '10.179.0.0/16'
            ]
          }
          remoteVirtualNetwork: {
            id: virtualNetworks_wwi_migration_vnet_dev_name_resource.id
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
              '10.179.0.0/16'
            ]
          }
          useRemoteGateways: false
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
  }
}

resource snet_etl 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
  name: '${project}-snet-etl-${environment}'
  parent: vnet_etl
  properties: {
    addressPrefix: '10.1.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource nseg_etl_bastion 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: 'eastus'
  name: '${project}-nseg-etl_bastion-${environment}'
  properties: {
    securityRules: [
      {
        name: '${project}-nsegrul-etl-bastion-ssh-${environment}'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefixes: []
          destinationPortRanges: [
            '22'
            '3389'
          ]
          direction: 'Outbound'
          priority: 100
          protocol: '*'
          sourceAddressPrefix: '*'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-etl-bastion-azure-${environment}'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: 'AzureCloud'
          destinationAddressPrefixes: []
          destinationPortRange: '443'
          destinationPortRanges: []
          direction: 'Outbound'
          priority: 110
          protocol: 'TCP'
          sourceAddressPrefix: '*'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-etl-bastion-outbound-${environment}'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefixes: []
          destinationPortRanges: [
            '8080'
            '5701'
          ]
          direction: 'Outbound'
          priority: 120
          protocol: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-etl-bastion-http-inbound-${environment}'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRange: '443'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 130
          protocol: 'TCP'
          sourceAddressPrefix: 'Internet'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-etl-bastion-load-balancer-${environment}'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRange: '443'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 150
          protocol: 'TCP'
          sourceAddressPrefix: 'AzureLoadBalancer'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-etl-bastion-gateway-manager-${environment}'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRange: '443'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 160
          protocol: 'TCP'
          sourceAddressPrefix: 'GatewayManager'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-etl-bastion-inbound-${environment}'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefixes: []
          destinationPortRanges: [
            '8080'
            '5701'
          ]
          direction: 'Inbound'
          priority: 170
          protocol: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        name: '${project}-nsegrul-etl-bastion-http-outbound-${environment}'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: 'Internet'
          destinationAddressPrefixes: []
          destinationPortRange: '80'
          destinationPortRanges: []
          direction: 'Outbound'
          priority: 180
          protocol: '*'
          sourceAddressPrefix: '*'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
    ]
  }
}

resource snet_etl_bastion 'Microsoft.Network/virtualNetworks/subnets@2023-05-01' = {
  name: '${project}-snet-etl-bastion-${environment}'
  parent: vnet_etl
  properties: {
    addressPrefix: '10.1.1.0/26'
    delegations: []
    networkSecurityGroup: {
      id: nseg_etl_bastion.id
    }
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}
