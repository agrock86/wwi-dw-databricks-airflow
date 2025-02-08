param project string
param env string
param admin_login string
@secure()
param admin_password string
param vnet_main object

var default_location = resourceGroup().location

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

resource snet_airflow 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${project}-snet-airflow-${env}'
  properties: {
    addressPrefix: '10.1.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource snet_airflow_bastion 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
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
  dependsOn: [
    snet_airflow // to guarantee sequential execution, since only 1 subnet can be provisioned at a time.
  ]
}

resource nic_airflow 'Microsoft.Network/networkInterfaces@2024-01-01' = {
  location: default_location
  name: '${project}-nic-${env}'
  properties: {
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          primary: true
          privateIPAddress: '10.1.0.4'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet_main.name, snet_airflow.name)
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    networkSecurityGroup: {
      id: resourceId('Microsoft.Network/networkSecurityGroups', nseg_airflow.name)
    }
    nicType: 'Standard'
  }
}

resource vm_airflow 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: '${project}-vm-airflow-${env}'
  identity: {
    type: 'SystemAssigned'
  }
  location: default_location
  properties: {
    additionalCapabilities: {
      hibernationEnabled: false
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic_airflow.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    osProfile: {
      adminUsername: admin_login
      adminPassword: admin_password
      allowExtensionOperations: true
      computerName: '${project}-vm-airflow-${env}'
      linuxConfiguration: {
        disablePasswordAuthentication: true
        patchSettings: {
          assessmentMode: 'ImageDefault'
          automaticByPlatformSettings: {
            rebootSetting: 'IfRequired'
          }
          patchMode: 'AutomaticByPlatform'
        }
        provisionVMAgent: true
        ssh: {
          publicKeys: [
            {
              // TO-DO: automatically generate key pair and add public key to the VM.
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6gPt4S5gLm9mQvA3cPzPYbNT0AbNHEo7Shevjm1IIDhZUDjDd1/J3ljY0tHDrKylrQ8INcuwTLhO1ckvjmyeGupRKN22HpYf+8htUQROtfzkFOwNUP1pZr6z/gWBBA+Ps3H1RkQhxL9euCdFYaql4M9eobFDXAMB1j7iuDI/diyGsUZEsIqB5WnPHBanoP8To1uSzkCtZS0zYuStW9bayI8K+gXPE/dhG2yFH7wgdg1qL5tP5aAx+liEmdbPZb5TG0Y4oHDiman8wOq+AOgWcOwWPDGD+Kk8q8aGyjIOcrWphvCg5g0Ncweek0uaVppjFIQnzcftHLXJzIQf7NjVQTwrZYnAUsUr2b7oVDbDpIlaBn6ATtHv/0RMbiSx1Qld6qbKSzO9rAfrCZQkGILTyZLNyFzak8q+BBNgnM6+QCz35KUG7rql1feFcp3PcB3vt7bxoyo+YOjinOwxKvf7Az8O/K5f1dwuIAEitADuwLiFuju+2EtIaOv3J/Luzyyk= generated-by-azure'
              path: '/home/${admin_login}/.ssh/authorized_keys'
            }
          ]
        }
      }
      secrets: []
    }
    storageProfile: {
      dataDisks: []
      diskControllerType: 'SCSI'
      imageReference: {
        offer: '0001-com-ubuntu-server-jammy'
        publisher: 'canonical'
        sku: '22_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        name: '${project}-disk-airflow-${env}'
        osType: 'Linux'
        caching: 'ReadWrite'
        createOption: 'FromImage'
        deleteOption: 'Delete'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
  }
}
