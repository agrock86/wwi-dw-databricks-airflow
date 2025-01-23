param project string
param environment string

var default_location = resourceGroup().location

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
    subnets: [
      {
        name: '${project}-snet-data-${environment}'
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
      {
        name: '${project}-snet-adb-private-${environment}'
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
      {
        name: '${project}-snet-adb-public-${environment}'
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
    ]
  }
}

resource nseg_adb 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: default_location
  name: '${project}-nseg-adb-${environment}'
  properties: {}

  resource nsegrul_adb_worker_inbound 'securityRules' = {
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
  }

  resource nsegrul_adb_plane_ssh 'securityRules' = {
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
  }

  resource nsegrul_adb_plane_worker 'securityRules' = {
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
  }

  resource nsegrul_adb_worker_outbound 'securityRules' = {
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
  }

  resource nsegrul_adb_worker_plane 'securityRules' = {
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
  }

  resource nsegrul_adb_worker_sql 'securityRules' = {
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
  }

  resource nsegrul_adb_worker_adsl 'securityRules' = {
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
  }

  resource nsegrul_adb_worker_ehub 'securityRules' = {
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
  }
}

resource vnet_etl 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  location: default_location
  name: '${project}-vnet-etl-${environment}'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    enableDdosProtection: false
    subnets: [
      {
        name: '${project}-snet-etl-${environment}'
        properties: {
          addressPrefix: '10.1.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: '${project}-snet-etl-bastion-${environment}'
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
    ]
  }
}

resource nseg_etl_bastion 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: default_location
  name: '${project}-nseg-etl-bastion-${environment}'
  properties: {}
  
  resource nsegrul_etl_bastion_ssh 'securityRules' = {
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
  }

  resource nsegrul_etl_bastion_azure 'securityRules' = {
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
  }
  
  resource nsegrul_etl_bastion_outbound 'securityRules' = {
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
  }

  resource nsegrul_etl_bastion_http_inbound 'securityRules' = {
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
  }

  resource nsegrul_etl_bastion_load_balancer 'securityRules' = {
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
  }
  
  resource nsegrul_etl_bastion_gateway_manager 'securityRules' = {
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
  }
  
  resource nsegrul_etl_bastion_inbound 'securityRules' = {
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
  }

  resource nsegrul_etl_bastion_http_outbound 'securityRules' = {
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
  }
}

resource vnetp_data_etl_dev 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-01-01' = {
  name: '${project}-vnetp-data-etl-${environment}'
  parent: vnet_data
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
      id: vnet_etl.id
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    useRemoteGateways: false
  }
}

resource vnetp_etl_data_dev 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-01-01' = {
  name: '${project}-vnetp-etl-data-${environment}'
  parent: vnet_etl
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
      id: vnet_data.id
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
        '10.179.0.0/16'
      ]
    }
    useRemoteGateways: false
  }
}

