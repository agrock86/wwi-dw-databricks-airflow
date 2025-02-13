param project string
param env string
param admin_login string
@secure()
param admin_password string
@secure()
param ssh_public_key string
param vnet_main object
param snet_airflow object

var default_location = resourceGroup().location

resource nseg_airflow 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: default_location
  name: '${project}-nseg-airflow-${env}'
  properties: {}

  resource nsegrul_airflow_ssh_rdp_inbound 'securityRules' = {
    name: 'SshRdpInbound'
    properties: {
      access: 'Allow'
      // destinationAddressPrefix: 'VirtualNetwork'
      destinationAddressPrefix: '*'
      destinationAddressPrefixes: []
      destinationPortRanges: [
        '22'
        '3389'
      ]
      direction: 'Inbound'
      priority: 100
      protocol: '*'
      // sourceAddressPrefix: '10.0.1.0/26'
      sourceAddressPrefix: '*'
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

resource pip_airflow 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  location: default_location
  name: '${project}-pip-airflow-${env}'
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic' // Use 'Static' if you need a fixed IP
    publicIPAddressVersion: 'IPv4'
  }
}

resource nic_airflow 'Microsoft.Network/networkInterfaces@2024-01-01' = {
  location: default_location
  name: '${project}-nic-airflow-${env}'
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
          publicIPAddress: {
            id: pip_airflow.id
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

resource sshk_vm_airflow 'Microsoft.Compute/sshPublicKeys@2022-11-01' = {
  location: default_location
  name: '${project}-sshk-vm-airflow-${env}'
  properties: {
    publicKey: ssh_public_key
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
              keyData: sshk_vm_airflow.properties.publicKey
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

resource vmext_airflow_setup 'Microsoft.Compute/virtualMachines/extensions@2024-07-01' = {
  location: default_location
  name: 'airflow_setup'
  parent: vm_airflow
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/agrock86/wwi-dw-databricks-airflow/refs/heads/main/infra/setup_docker.sh'
        'https://raw.githubusercontent.com/agrock86/wwi-dw-databricks-airflow/refs/heads/main/infra/setup_airflow.sh'
        'https://raw.githubusercontent.com/agrock86/wwi-dw-databricks-airflow/refs/heads/main/infra/setup.sh'
      ]
      commandToExecute: 'sudo sh setup.sh'
    }
  }
}
