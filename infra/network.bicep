param project string
param env string

var default_location = resourceGroup().location

resource vnet_etl 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  location: default_location
  name: '${project}-vnet-etl-${env}'
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
      {
        name: '${project}-snet-airflow-${env}'
        properties: {
          addressPrefix: '10.1.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: '${project}-snet-airflow-bastion-${env}'
        properties: {
          addressPrefix: '10.1.1.0/26'
          delegations: []
          networkSecurityGroup: {
            id: nseg_airflow_bastion.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
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

resource nseg_airflow 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: default_location
  name: '${project}-nseg-airflow-${env}'
  properties: {}

  resource nsegrul_airflow_ssh_rdp_inbound 'securityRules' = {
    name: 'SshRdpInbound'
    properties: {
      access: 'Allow'
      destinationAddressPrefix: 'VirtualNetwork'
      destinationAddressPrefixes: []
      destinationPortRanges: [
        '22'
        '3389'
      ]
      direction: 'Inbound'
      priority: 100
      protocol: '*'
      sourceAddressPrefix: '10.0.1.0/26'
      sourceAddressPrefixes: []
      sourcePortRange: '*'
      sourcePortRanges: []
    }
  }

  resource nsegrul_airflow_http_inbound 'securityRules' = {
    name: 'HttpInbound'
    properties: {
      access: 'Allow'
      destinationAddressPrefix: 'VirtualNetwork'
      destinationAddressPrefixes: []
      destinationPortRange: '8080'
      destinationPortRanges: []
      direction: 'Inbound'
      priority: 110
      protocol: '*'
      sourceAddressPrefix: '10.0.1.0/26'
      sourceAddressPrefixes: []
      sourcePortRange: '*'
      sourcePortRanges: []
    }
  }
}

resource nseg_airflow_bastion 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: default_location
  name: '${project}-nseg-airflow-bastion-${env}'
  properties: {}
  
  resource nsegrul_etl_bastion_ssh 'securityRules' = {
    name: 'SshRdpOutbound'
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
    name: 'AzureCloudOutbound'
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
    name: 'BastionCommOutbound'
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
    name: 'HttpsInbound'
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
    name: 'LoadBalancerInbound'
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
    name: 'GatewayManagerInbound'
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
    name: 'BastionHostCommInbound'
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
    name: 'AnyHttpOutbound'
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
