param accessConnectors_externalid string
param bastionHosts_wwi_migration_bst_aflw_dev_name string

@secure()
param extensions_enablevmAccess_expiration string

@secure()
param extensions_enablevmAccess_password string

@secure()
param extensions_enablevmAccess_remove_user string

@secure()
param extensions_enablevmAccess_reset_ssh string

@secure()
param extensions_enablevmAccess_ssh_key string

@secure()
param extensions_enablevmAccess_username string
param networkInterfaces_wwi_migration_vm_aflw_dev251_name string
param networkSecurityGroups_databricksnsglw47yhy3wcrcs_name string
param networkSecurityGroups_wwimigrationvmaflwdevnsg858_name string
param networkSecurityGroups_wwimigrationvmaflwdevnsg859_name string
param privateDnsZones_privatelink_azuredatabricks_net_name string
param privateDnsZones_privatelink_database_windows_net_name string
param privateDnsZones_privatelink_dfs_core_windows_net_name string
param privateDnsZones_privatelink_vaultcore_azure_net_name string
param privateEndpoints_wwi_migration_pep_adb_dev_name string
param privateEndpoints_wwi_migration_pep_kv_dev_name string
param privateEndpoints_wwi_migration_pep_msql_dev_name string
param privateEndpoints_wwi_migration_pep_st_dev_name string
param publicIPAddresses_wwi_migration_vm_aflw_dev_vnet_ip_name string
param servers_wwi_migration_agrock86_name string
param sshPublicKeys_wwi_migration_aflw_dev_key_name string
param sshPublicKeys_wwi_migration_key_vm_aflw_dev_name string
param sshPublicKeys_wwi_migration_keyp_aflw_dev_name string
param sshPublicKeys_wwi_migration_keyp_vm_aflw_dev_name string
param storageAccounts_wwimigrstdevagrock86_name string
param vaults_wwi_migration_kv_dev_name string
param virtualMachines_wwi_migration_vm_aflw_dev_name string
param virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name string
param virtualNetworks_wwi_migration_vnet_dev_name string

@secure()
param vulnerabilityAssessments_Default_storageContainerPath string
param workspaces_wwi_migration_v2_adb_dev_name string

resource sshPublicKeys_wwi_migration_aflw_dev_key_name_resource 'Microsoft.Compute/sshPublicKeys@2024-07-01' = {
  location: 'eastus'
  name: sshPublicKeys_wwi_migration_aflw_dev_key_name
  properties: {
    publicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC792xiB6Gff7gwwEuOJzqiIEO9meQzU1oE530ReDjw3yvt1Ypc2ogsHBLu31bbMEs+ljCRCRdR8DLOeokC4s4Gn2OFyShnzUxeJBIJ8wAGiLpO3uYBHaDn5FC5KWY90vJbwnHNOzZHulzC+DMgbn4YHZfwYkGMJRV2KduC4zg7PhD1MECR3ijuYCIXGqbFSGFiqRcBKU0TA595msZ3QRFr504Rudb9QNJAbVXL1oQdLTlAY3MJp20r0TEmqo8rp3sc8nTqvHkqhA2GdY3A6tEWX260vT86wdiEbWDxvrmkFe2mwP6ttQ7QkyXy+hajYIcQ+CVYcBcWPz7fOhqh07Q8tErxR4/r7KG1RGXcVBDKvv2+UqNRkTHbV4xbP1s9Ej0XPSy4+L/5fT3WUAkiLnRBRNY4JBnZZGmTSog/oLZrvskp1MUc33Oi6UvC9z2XjUnIwAIROe1YzEntIxmejt7+D2W46q5Jl1wNvS5LfKO1/CnZRUBH8bvXJRSfBFWVCP0= generated-by-azure'
  }
}

resource sshPublicKeys_wwi_migration_keyp_aflw_dev_name_resource 'Microsoft.Compute/sshPublicKeys@2024-07-01' = {
  location: 'eastus'
  name: sshPublicKeys_wwi_migration_keyp_aflw_dev_name
  properties: {
    publicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpY9N/pIeC3ZF0LZk4mUFLiaWYhk1+jdkD9RYvegopeBLOR702T+eVWf4928dFq7SOFEethX+F9uep0aQ48PbGusL4SPad02GBeUVf84ztoayzsN3ll75nVUsqFHIVEh0g2NbN9kZe+KJqFfjL5HMindz+ETn79b+m6/Cwg2t0TROwdzZMtPUtnS5AWSGTeq3Qz/OfTm2JjeALhP+rpho7Ivhyg8/ERSLaYgWTQz1uuQrw49M6cUAsk5u8x+9AfPFQTRTQ5J0EOTaaUUfO+ZK8PD+eJbsGHbU1FaxCgG9U33g9at43mzSLDtnhpa+ZIYMS1Sx86FjydgtMVJIir4RhvgLTVqpDjAVuRYc2ETmb0ZkYcCNX3+aaUEivtUP5RVpwJWrwcraakqM04XQ8r4dGLD+4xqGu46pRKPULl2020Yy0125W9nQBrrqU8XdrGYSJXw728ELxlqq1Y1gq1w72zOjlrPSmgiESMfxDBtwS22pv4OrDGHTswIA20B43lME= generated-by-azure'
  }
}

resource sshPublicKeys_wwi_migration_keyp_vm_aflw_dev_name_resource 'Microsoft.Compute/sshPublicKeys@2024-07-01' = {
  location: 'eastus'
  name: sshPublicKeys_wwi_migration_keyp_vm_aflw_dev_name
  properties: {
    publicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6gPt4S5gLm9mQvA3cPzPYbNT0AbNHEo7Shevjm1IIDhZUDjDd1/J3ljY0tHDrKylrQ8INcuwTLhO1ckvjmyeGupRKN22HpYf+8htUQROtfzkFOwNUP1pZr6z/gWBBA+Ps3H1RkQhxL9euCdFYaql4M9eobFDXAMB1j7iuDI/diyGsUZEsIqB5WnPHBanoP8To1uSzkCtZS0zYuStW9bayI8K+gXPE/dhG2yFH7wgdg1qL5tP5aAx+liEmdbPZb5TG0Y4oHDiman8wOq+AOgWcOwWPDGD+Kk8q8aGyjIOcrWphvCg5g0Ncweek0uaVppjFIQnzcftHLXJzIQf7NjVQTwrZYnAUsUr2b7oVDbDpIlaBn6ATtHv/0RMbiSx1Qld6qbKSzO9rAfrCZQkGILTyZLNyFzak8q+BBNgnM6+QCz35KUG7rql1feFcp3PcB3vt7bxoyo+YOjinOwxKvf7Az8O/K5f1dwuIAEitADuwLiFuju+2EtIaOv3J/Luzyyk= generated-by-azure'
  }
}

resource sshPublicKeys_wwi_migration_key_vm_aflw_dev_name_resource 'Microsoft.Compute/sshPublicKeys@2024-07-01' = {
  location: 'eastus'
  name: sshPublicKeys_wwi_migration_key_vm_aflw_dev_name
  properties: {
    publicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDG1CHZ1FWNPyMT3bW6diuujICNSG6xbaisQHHjH8qDI6jFEoPQOiI0dhXgSd9yIzRDCeJ4ogkbYufiX35mGT03VuiHlbsneDh3wwZElzYq84I37pGWOV+BKPVHYxckHzgL+8+bDyy6hWLcLI4GLfSI4FknPz/LIRIBHDazJVQ9+/au8/Bnkj7l2Rc/rfFKJIUtHZx6DGx2iF1YtiY6LPjk4cO9YKLO7MOWLUrc1zVgpGwBu8xkcxqtsMD/PFBfWCuEpz7My119Q/x9xV2L4SrfVt1k7xuIIS87Z+0mCy3jTW2+E9lytHpwUVQrAp1cg64k3bLQZkgkYVxm3pnLKC6aeuXbUbyjqbtL9BKEAwPXAZARLqHA1RN4pB3yKZeANci7Cz2Ss/Jb49bcdEkv44/XRZu6SNx6Lwodbx6vIWD51dEywyKC578f3muFc4jvFCqLMop5FhfbNIy5jw+wx6Bs/bW18fstbBV8ubQUDQ+s/sco0NJ866OI2IM+HoTz/Jk= generated-by-azure'
  }
}

resource vaults_wwi_migration_kv_dev_name_resource 'Microsoft.KeyVault/vaults@2024-04-01-preview' = {
  location: 'eastus'
  name: vaults_wwi_migration_kv_dev_name
  properties: {
    accessPolicies: [
      {
        objectId: '4b93b890-a242-45d3-9d59-2c4d1741f9ca'
        permissions: {
          certificates: []
          keys: []
          secrets: [
            'Get'
            'List'
          ]
        }
        tenantId: '5f751a8a-2fcf-4979-9e68-b20f298c27ba'
      }
      {
        objectId: '5019235e-f816-4d7b-ae28-5bdf15e7e117'
        permissions: {
          certificates: [
            'Get'
            'List'
            'Update'
            'Create'
            'Import'
            'Delete'
            'Recover'
            'Backup'
            'Restore'
            'ManageContacts'
            'ManageIssuers'
            'GetIssuers'
            'ListIssuers'
            'SetIssuers'
            'DeleteIssuers'
            'Purge'
          ]
          keys: [
            'Get'
            'List'
            'Update'
            'Create'
            'Import'
            'Delete'
            'Recover'
            'Backup'
            'Restore'
            'GetRotationPolicy'
            'SetRotationPolicy'
            'Rotate'
            'Encrypt'
            'Decrypt'
            'UnwrapKey'
            'WrapKey'
            'Verify'
            'Sign'
            'Purge'
            'Release'
          ]
          secrets: [
            'Get'
            'List'
            'Set'
            'Delete'
            'Recover'
            'Backup'
            'Restore'
            'Purge'
          ]
        }
        tenantId: '5f751a8a-2fcf-4979-9e68-b20f298c27ba'
      }
    ]
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Disabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 90
    tenantId: '5f751a8a-2fcf-4979-9e68-b20f298c27ba'
    vaultUri: 'https://${vaults_wwi_migration_kv_dev_name}.vault.azure.net/'
  }
}

resource networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: 'eastus'
  name: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name
  properties: {
    securityRules: [
      {
        id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_worker_inbound.id
        name: 'Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-worker-inbound'
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
        id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_control_plane_to_worker_ssh.id
        name: 'Microsoft.Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-ssh'
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
        id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_control_plane_to_worker_proxy.id
        name: 'Microsoft.Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-proxy'
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
        id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_worker_outbound.id
        name: 'Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-worker-outbound'
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
        id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_databricks_cp.id
        name: 'Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-databricks-cp'
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
        id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_sql.id
        name: 'Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-sql'
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
        id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_storage.id
        name: 'Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-storage'
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
        id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_eventhub.id
        name: 'Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-eventhub'
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

resource networkSecurityGroups_wwimigrationvmaflwdevnsg858_name_resource 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: 'eastus'
  name: networkSecurityGroups_wwimigrationvmaflwdevnsg858_name
  properties: {
    securityRules: [
      {
        id: networkSecurityGroups_wwimigrationvmaflwdevnsg858_name_AllowSshRdpInbound.id
        name: 'AllowSshRdpInbound'
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
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
      {
        id: networkSecurityGroups_wwimigrationvmaflwdevnsg858_name_AllowHttpInbound.id
        name: 'AllowHttpInbound'
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
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
      }
    ]
  }
}

resource networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_resource 'Microsoft.Network/networkSecurityGroups@2024-01-01' = {
  location: 'eastus'
  name: networkSecurityGroups_wwimigrationvmaflwdevnsg859_name
  properties: {
    securityRules: [
      {
        id: networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowSshRdpOutbound.id
        name: 'AllowSshRdpOutbound'
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
        id: networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowAzureCloudOutbound.id
        name: 'AllowAzureCloudOutbound'
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
        id: networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowBastionCommOutbound.id
        name: 'AllowBastionCommOutbound'
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
        id: networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowHttpsInbound.id
        name: 'AllowHttpsInbound'
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
        id: networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowLoadBalancerInbound.id
        name: 'AllowLoadBalancerInbound'
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
        id: networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowGatewayManagerInbound.id
        name: 'AllowGatewayManagerInbound'
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
        id: networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowBastionHostCommInbound.id
        name: 'AllowBastionHostCommInbound'
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
        id: networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowAnyHttpOutbound.id
        name: 'AllowAnyHttpOutbound'
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

resource privateDnsZones_privatelink_azuredatabricks_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  location: 'global'
  name: privateDnsZones_privatelink_azuredatabricks_net_name
  properties: {}
}

resource privateDnsZones_privatelink_database_windows_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  location: 'global'
  name: privateDnsZones_privatelink_database_windows_net_name
  properties: {}
}

resource privateDnsZones_privatelink_dfs_core_windows_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  location: 'global'
  name: privateDnsZones_privatelink_dfs_core_windows_net_name
  properties: {}
}

resource privateDnsZones_privatelink_vaultcore_azure_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  location: 'global'
  name: privateDnsZones_privatelink_vaultcore_azure_net_name
  properties: {}
}

resource publicIPAddresses_wwi_migration_vm_aflw_dev_vnet_ip_name_resource 'Microsoft.Network/publicIPAddresses@2024-01-01' = {
  location: 'eastus'
  name: publicIPAddresses_wwi_migration_vm_aflw_dev_vnet_ip_name
  properties: {
    idleTimeoutInMinutes: 4
    ipAddress: '48.216.200.203'
    ipTags: []
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '3'
    '2'
    '1'
  ]
}

resource servers_wwi_migration_agrock86_name_resource 'Microsoft.Sql/servers@2023-08-01-preview' = {
  kind: 'v12.0'
  location: 'eastus'
  name: servers_wwi_migration_agrock86_name
  properties: {
    administratorLogin: 'syadmin'
    administrators: {
      administratorType: 'ActiveDirectory'
      azureADOnlyAuthentication: false
      login: 'twinsensor_hotmail.com#EXT#@twinsensorhotmail.onmicrosoft.com'
      principalType: 'User'
      sid: '5019235e-f816-4d7b-ae28-5bdf15e7e117'
      tenantId: '5f751a8a-2fcf-4979-9e68-b20f298c27ba'
    }
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Disabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

resource virtualMachines_wwi_migration_vm_aflw_dev_name_resource 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  identity: {
    type: 'SystemAssigned'
  }
  location: 'eastus'
  name: virtualMachines_wwi_migration_vm_aflw_dev_name
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
          id: networkInterfaces_wwi_migration_vm_aflw_dev251_name_resource.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    osProfile: {
      adminUsername: 'azureuser'
      allowExtensionOperations: true
      computerName: virtualMachines_wwi_migration_vm_aflw_dev_name
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
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6gPt4S5gLm9mQvA3cPzPYbNT0AbNHEo7Shevjm1IIDhZUDjDd1/J3ljY0tHDrKylrQ8INcuwTLhO1ckvjmyeGupRKN22HpYf+8htUQROtfzkFOwNUP1pZr6z/gWBBA+Ps3H1RkQhxL9euCdFYaql4M9eobFDXAMB1j7iuDI/diyGsUZEsIqB5WnPHBanoP8To1uSzkCtZS0zYuStW9bayI8K+gXPE/dhG2yFH7wgdg1qL5tP5aAx+liEmdbPZb5TG0Y4oHDiman8wOq+AOgWcOwWPDGD+Kk8q8aGyjIOcrWphvCg5g0Ncweek0uaVppjFIQnzcftHLXJzIQf7NjVQTwrZYnAUsUr2b7oVDbDpIlaBn6ATtHv/0RMbiSx1Qld6qbKSzO9rAfrCZQkGILTyZLNyFzak8q+BBNgnM6+QCz35KUG7rql1feFcp3PcB3vt7bxoyo+YOjinOwxKvf7Az8O/K5f1dwuIAEitADuwLiFuju+2EtIaOv3J/Luzyyk= generated-by-azure'
              path: '/home/azureuser/.ssh/authorized_keys'
            }
          ]
        }
      }
      requireGuestProvisionSignal: true
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
        caching: 'ReadWrite'
        createOption: 'FromImage'
        deleteOption: 'Delete'
        managedDisk: {
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_wwi_migration_vm_aflw_dev_name}_disk1_6b6b87d494ff427a83d60d4cdb050c55'
          )
        }
        name: '${virtualMachines_wwi_migration_vm_aflw_dev_name}_disk1_6b6b87d494ff427a83d60d4cdb050c55'
        osType: 'Linux'
      }
    }
  }
}

resource virtualMachines_wwi_migration_vm_aflw_dev_name_enablevmAccess 'Microsoft.Compute/virtualMachines/extensions@2024-07-01' = {
  parent: virtualMachines_wwi_migration_vm_aflw_dev_name_resource
  location: 'eastus'
  name: 'enablevmAccess'
  properties: {
    autoUpgradeMinorVersion: true
    protectedSettings: {
      expiration: extensions_enablevmAccess_expiration
      password: extensions_enablevmAccess_password
      remove_user: extensions_enablevmAccess_remove_user
      reset_ssh: extensions_enablevmAccess_reset_ssh
      ssh_key: extensions_enablevmAccess_ssh_key
      username: extensions_enablevmAccess_username
    }
    publisher: 'Microsoft.OSTCExtensions'
    settings: {}
    type: 'VMAccessForLinux'
    typeHandlerVersion: '1.5'
  }
}

resource workspaces_wwi_migration_v2_adb_dev_name_resource 'Microsoft.Databricks/workspaces@2024-05-01' = {
  location: 'eastus'
  name: workspaces_wwi_migration_v2_adb_dev_name
  properties: {
    authorizations: [
      {
        principalId: '9a74af6f-d153-4348-988a-e2672920bee9'
        roleDefinitionId: '8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
      }
    ]
    createdBy: {}
    defaultCatalog: {
      initialType: 'UnityCatalog'
    }
    managedResourceGroupId: '/subscriptions/b3a28b83-62b4-491c-911a-47064b617cda/resourceGroups/wwi-migration-v2-rg-databricks-dev'
    parameters: {
      customPrivateSubnetName: {
        value: 'private-subnet'
      }
      customPublicSubnetName: {
        value: 'public-subnet'
      }
      customVirtualNetworkId: {
        value: virtualNetworks_wwi_migration_vnet_dev_name_resource.id
      }
      enableNoPublicIp: {
        value: false
      }
      prepareEncryption: {
        value: false
      }
      publicIpName: {
        value: 'nat-gw-public-ip'
      }
      requireInfrastructureEncryption: {
        value: false
      }
      storageAccountName: {
        value: 'dbstorage4bwdxhikm2vgy'
      }
      storageAccountSkuName: {
        value: 'Standard_GRS'
      }
      vnetAddressPrefix: {
        value: '10.139'
      }
    }
    publicNetworkAccess: 'Enabled'
    requiredNsgRules: 'AllRules'
    updatedBy: {}
  }
  sku: {
    name: 'premium'
  }
}

resource workspaces_wwi_migration_v2_adb_dev_name_wwi_migration_pep_adb_dev 'Microsoft.Databricks/workspaces/privateEndpointConnections@2024-05-01' = {
  parent: workspaces_wwi_migration_v2_adb_dev_name_resource
  name: 'wwi-migration-pep-adb-dev'
  properties: {
    groupIds: [
      'databricks_ui_api'
    ]
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      actionsRequired: 'None'
      description: 'Auto-approved'
      status: 'Approved'
    }
  }
}

resource vaults_wwi_migration_kv_dev_name_wwi_migration_pep_kv_dev 'Microsoft.KeyVault/vaults/privateEndpointConnections@2024-04-01-preview' = {
  parent: vaults_wwi_migration_kv_dev_name_resource
  location: 'eastus'
  name: 'wwi-migration-pep-kv-dev'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      actionsRequired: 'None'
      status: 'Approved'
    }
    provisioningState: 'Succeeded'
  }
}

resource vaults_wwi_migration_kv_dev_name_wwi_db_host 'Microsoft.KeyVault/vaults/secrets@2024-04-01-preview' = {
  parent: vaults_wwi_migration_kv_dev_name_resource
  location: 'eastus'
  name: 'wwi-db-host'
  properties: {
    attributes: {
      enabled: true
    }
  }
}

resource vaults_wwi_migration_kv_dev_name_wwi_db_name 'Microsoft.KeyVault/vaults/secrets@2024-04-01-preview' = {
  parent: vaults_wwi_migration_kv_dev_name_resource
  location: 'eastus'
  name: 'wwi-db-name'
  properties: {
    attributes: {
      enabled: true
    }
  }
}

resource vaults_wwi_migration_kv_dev_name_wwi_db_password 'Microsoft.KeyVault/vaults/secrets@2024-04-01-preview' = {
  parent: vaults_wwi_migration_kv_dev_name_resource
  location: 'eastus'
  name: 'wwi-db-password'
  properties: {
    attributes: {
      enabled: true
    }
  }
}

resource vaults_wwi_migration_kv_dev_name_wwi_db_username 'Microsoft.KeyVault/vaults/secrets@2024-04-01-preview' = {
  parent: vaults_wwi_migration_kv_dev_name_resource
  location: 'eastus'
  name: 'wwi-db-username'
  properties: {
    attributes: {
      enabled: true
    }
  }
}

resource networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowAnyHttpOutbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_wwimigrationvmaflwdevnsg859_name}/AllowAnyHttpOutbound'
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
  dependsOn: [
    networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_resource
  ]
}

resource networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowAzureCloudOutbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_wwimigrationvmaflwdevnsg859_name}/AllowAzureCloudOutbound'
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
  dependsOn: [
    networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_resource
  ]
}

resource networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowBastionCommOutbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_wwimigrationvmaflwdevnsg859_name}/AllowBastionCommOutbound'
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
  dependsOn: [
    networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_resource
  ]
}

resource networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowBastionHostCommInbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_wwimigrationvmaflwdevnsg859_name}/AllowBastionHostCommInbound'
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
  dependsOn: [
    networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_resource
  ]
}

resource networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowGatewayManagerInbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_wwimigrationvmaflwdevnsg859_name}/AllowGatewayManagerInbound'
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
  dependsOn: [
    networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_resource
  ]
}

resource networkSecurityGroups_wwimigrationvmaflwdevnsg858_name_AllowHttpInbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_wwimigrationvmaflwdevnsg858_name}/AllowHttpInbound'
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
  dependsOn: [
    networkSecurityGroups_wwimigrationvmaflwdevnsg858_name_resource
  ]
}

resource networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowHttpsInbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_wwimigrationvmaflwdevnsg859_name}/AllowHttpsInbound'
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
  dependsOn: [
    networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_resource
  ]
}

resource networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowLoadBalancerInbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_wwimigrationvmaflwdevnsg859_name}/AllowLoadBalancerInbound'
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
  dependsOn: [
    networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_resource
  ]
}

resource networkSecurityGroups_wwimigrationvmaflwdevnsg858_name_AllowSshRdpInbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_wwimigrationvmaflwdevnsg858_name}/AllowSshRdpInbound'
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
  dependsOn: [
    networkSecurityGroups_wwimigrationvmaflwdevnsg858_name_resource
  ]
}

resource networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_AllowSshRdpOutbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_wwimigrationvmaflwdevnsg859_name}/AllowSshRdpOutbound'
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
  dependsOn: [
    networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_resource
  ]
}

resource networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_control_plane_to_worker_proxy 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_databricksnsglw47yhy3wcrcs_name}/Microsoft.Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-proxy'
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
  dependsOn: [
    networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource
  ]
}

resource networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_control_plane_to_worker_ssh 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_databricksnsglw47yhy3wcrcs_name}/Microsoft.Databricks-workspaces_UseOnly_databricks-control-plane-to-worker-ssh'
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
  dependsOn: [
    networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource
  ]
}

resource networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_databricks_cp 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_databricksnsglw47yhy3wcrcs_name}/Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-databricks-cp'
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
  dependsOn: [
    networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource
  ]
}

resource networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_eventhub 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_databricksnsglw47yhy3wcrcs_name}/Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-eventhub'
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
  dependsOn: [
    networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource
  ]
}

resource networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_sql 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_databricksnsglw47yhy3wcrcs_name}/Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-sql'
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
  dependsOn: [
    networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource
  ]
}

resource networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_storage 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_databricksnsglw47yhy3wcrcs_name}/Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-storage'
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
  dependsOn: [
    networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource
  ]
}

resource networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_worker_inbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_databricksnsglw47yhy3wcrcs_name}/Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-worker-inbound'
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
  dependsOn: [
    networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource
  ]
}

resource networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_Microsoft_Databricks_workspaces_UseOnly_databricks_worker_to_worker_outbound 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = {
  name: '${networkSecurityGroups_databricksnsglw47yhy3wcrcs_name}/Microsoft.Databricks-workspaces_UseOnly_databricks-worker-to-worker-outbound'
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
  dependsOn: [
    networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource
  ]
}

resource privateDnsZones_privatelink_azuredatabricks_net_name_adb_384511669714116_16 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_azuredatabricks_net_name_resource
  name: 'adb-384511669714116.16'
  properties: {
    aRecords: [
      {
        ipv4Address: '10.0.0.5'
      }
    ]
    metadata: {
      creator: 'created by private endpoint wwi-migration-pep-adb-dev with resource guid a9d9a56d-8439-4b8d-b2ba-593d2b1f96f4'
    }
    ttl: 10
  }
}

resource privateDnsZones_privatelink_database_windows_net_name_wwi_migration_agrock86 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_database_windows_net_name_resource
  name: 'wwi-migration-agrock86'
  properties: {
    aRecords: [
      {
        ipv4Address: '10.0.0.4'
      }
    ]
    metadata: {
      creator: 'created by private endpoint wwi-migration-pep-msql-dev with resource guid 5e7382d5-9b20-4a07-847e-6ec41723eace'
    }
    ttl: 10
  }
}

resource privateDnsZones_privatelink_vaultcore_azure_net_name_wwi_migration_kv_dev 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_vaultcore_azure_net_name_resource
  name: 'wwi-migration-kv-dev'
  properties: {
    aRecords: [
      {
        ipv4Address: '10.0.0.6'
      }
    ]
    metadata: {
      creator: 'created by private endpoint wwi-migration-pep-kv-dev with resource guid dbf3b76b-6e35-4668-9226-9b486f9cd842'
    }
    ttl: 10
  }
}

resource privateDnsZones_privatelink_dfs_core_windows_net_name_wwimigrstdevagrock86 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_dfs_core_windows_net_name_resource
  name: 'wwimigrstdevagrock86'
  properties: {
    aRecords: [
      {
        ipv4Address: '10.0.0.7'
      }
    ]
    metadata: {
      creator: 'created by private endpoint wwi-migration-pep-st-dev with resource guid 3e6e1eb7-5e97-4ea4-ba18-25ebe1b3baa3'
    }
    ttl: 10
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_azuredatabricks_net_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_azuredatabricks_net_name_resource
  name: '@'
  properties: {
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
    ttl: 3600
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_database_windows_net_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_database_windows_net_name_resource
  name: '@'
  properties: {
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
    ttl: 3600
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_dfs_core_windows_net_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_dfs_core_windows_net_name_resource
  name: '@'
  properties: {
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
    ttl: 3600
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_vaultcore_azure_net_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_vaultcore_azure_net_name_resource
  name: '@'
  properties: {
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
    ttl: 3600
  }
}

resource virtualNetworks_wwi_migration_vnet_dev_name_default 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${virtualNetworks_wwi_migration_vnet_dev_name}/default'
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpoints: [
      {
        locations: [
          'eastus'
          'westus'
          'westus3'
        ]
        service: 'Microsoft.Storage'
      }
    ]
  }
  dependsOn: [
    virtualNetworks_wwi_migration_vnet_dev_name_resource
  ]
}

resource virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_default2 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name}/default2'
  properties: {
    addressPrefix: '10.1.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_resource
  ]
}

resource servers_wwi_migration_agrock86_name_ActiveDirectory 'Microsoft.Sql/servers/administrators@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'ActiveDirectory'
  properties: {
    administratorType: 'ActiveDirectory'
    login: 'twinsensor_hotmail.com#EXT#@twinsensorhotmail.onmicrosoft.com'
    sid: '5019235e-f816-4d7b-ae28-5bdf15e7e117'
    tenantId: '5f751a8a-2fcf-4979-9e68-b20f298c27ba'
  }
}

resource servers_wwi_migration_agrock86_name_Default 'Microsoft.Sql/servers/advancedThreatProtectionSettings@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource servers_wwi_migration_agrock86_name_CreateIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'CreateIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_wwi_migration_agrock86_name_DbParameterization 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'DbParameterization'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_wwi_migration_agrock86_name_DefragmentIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'DefragmentIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_wwi_migration_agrock86_name_DropIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'DropIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_wwi_migration_agrock86_name_ForceLastGoodPlan 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'ForceLastGoodPlan'
  properties: {
    autoExecuteValue: 'Enabled'
  }
}

resource Microsoft_Sql_servers_auditingPolicies_servers_wwi_migration_agrock86_name_Default 'Microsoft.Sql/servers/auditingPolicies@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_resource
  location: 'East US'
  name: 'Default'
  properties: {
    auditingState: 'Disabled'
  }
}

resource Microsoft_Sql_servers_auditingSettings_servers_wwi_migration_agrock86_name_Default 'Microsoft.Sql/servers/auditingSettings@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'default'
  properties: {
    auditActionsAndGroups: []
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    isStorageSecondaryKeyInUse: false
    retentionDays: 0
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource Microsoft_Sql_servers_azureADOnlyAuthentications_servers_wwi_migration_agrock86_name_Default 'Microsoft.Sql/servers/azureADOnlyAuthentications@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'Default'
  properties: {
    azureADOnlyAuthentication: false
  }
}

resource Microsoft_Sql_servers_connectionPolicies_servers_wwi_migration_agrock86_name_default 'Microsoft.Sql/servers/connectionPolicies@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  location: 'eastus'
  name: 'default'
  properties: {
    connectionType: 'Default'
  }
}

resource servers_wwi_migration_agrock86_name_WideWorldImporters 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  kind: 'v12.0,user,vcore,serverless,freelimit'
  location: 'eastus'
  name: 'WideWorldImporters'
  properties: {
    autoPauseDelay: 60
    availabilityZone: 'NoPreference'
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    freeLimitExhaustionBehavior: 'AutoPause'
    isLedgerOn: false
    maintenanceConfigurationId: '/subscriptions/b3a28b83-62b4-491c-911a-47064b617cda/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    maxSizeBytes: 34359738368
    minCapacity: json('0.5')
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Local'
    useFreeLimit: true
    zoneRedundant: false
  }
  sku: {
    capacity: 2
    family: 'Gen5'
    name: 'GP_S_Gen5'
    tier: 'GeneralPurpose'
  }
}

resource servers_wwi_migration_agrock86_name_master_Default 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2023-08-01-preview' = {
  name: '${servers_wwi_migration_agrock86_name}/master/Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingPolicies_servers_wwi_migration_agrock86_name_master_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
  location: 'East US'
  name: '${servers_wwi_migration_agrock86_name}/master/Default'
  properties: {
    auditingState: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingSettings_servers_wwi_migration_agrock86_name_master_Default 'Microsoft.Sql/servers/databases/auditingSettings@2023-08-01-preview' = {
  name: '${servers_wwi_migration_agrock86_name}/master/Default'
  properties: {
    isAzureMonitorTargetEnabled: false
    retentionDays: 0
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_extendedAuditingSettings_servers_wwi_migration_agrock86_name_master_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2023-08-01-preview' = {
  name: '${servers_wwi_migration_agrock86_name}/master/Default'
  properties: {
    isAzureMonitorTargetEnabled: false
    retentionDays: 0
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_geoBackupPolicies_servers_wwi_migration_agrock86_name_master_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2023-08-01-preview' = {
  name: '${servers_wwi_migration_agrock86_name}/master/Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource servers_wwi_migration_agrock86_name_master_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2023-08-01-preview' = {
  name: '${servers_wwi_migration_agrock86_name}/master/Current'
  properties: {}
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_securityAlertPolicies_servers_wwi_migration_agrock86_name_master_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2023-08-01-preview' = {
  name: '${servers_wwi_migration_agrock86_name}/master/Default'
  properties: {
    disabledAlerts: [
      ''
    ]
    emailAccountAdmins: false
    emailAddresses: [
      ''
    ]
    retentionDays: 0
    state: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_transparentDataEncryption_servers_wwi_migration_agrock86_name_master_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2023-08-01-preview' = {
  name: '${servers_wwi_migration_agrock86_name}/master/Current'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_servers_wwi_migration_agrock86_name_master_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2023-08-01-preview' = {
  name: '${servers_wwi_migration_agrock86_name}/master/Default'
  properties: {
    recurringScans: {
      emailSubscriptionAdmins: true
      isEnabled: false
    }
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_devOpsAuditingSettings_servers_wwi_migration_agrock86_name_Default 'Microsoft.Sql/servers/devOpsAuditingSettings@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'Default'
  properties: {
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource servers_wwi_migration_agrock86_name_current 'Microsoft.Sql/servers/encryptionProtector@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  kind: 'servicemanaged'
  name: 'current'
  properties: {
    autoRotationEnabled: false
    serverKeyName: 'ServiceManaged'
    serverKeyType: 'ServiceManaged'
  }
}

resource Microsoft_Sql_servers_extendedAuditingSettings_servers_wwi_migration_agrock86_name_Default 'Microsoft.Sql/servers/extendedAuditingSettings@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'default'
  properties: {
    auditActionsAndGroups: []
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    isStorageSecondaryKeyInUse: false
    retentionDays: 0
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource servers_wwi_migration_agrock86_name_AllowAllWindowsAzureIps 'Microsoft.Sql/servers/firewallRules@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'AllowAllWindowsAzureIps'
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}

resource servers_wwi_migration_agrock86_name_ClientIPAddress_2025_1_7_12_17_46 'Microsoft.Sql/servers/firewallRules@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'ClientIPAddress_2025-1-7_12-17-46'
  properties: {
    endIpAddress: '186.121.50.93'
    startIpAddress: '186.121.50.93'
  }
}

resource servers_wwi_migration_agrock86_name_ServiceManaged 'Microsoft.Sql/servers/keys@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  kind: 'servicemanaged'
  name: 'ServiceManaged'
  properties: {
    serverKeyType: 'ServiceManaged'
  }
}

resource Microsoft_Sql_servers_securityAlertPolicies_servers_wwi_migration_agrock86_name_Default 'Microsoft.Sql/servers/securityAlertPolicies@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'Default'
  properties: {
    disabledAlerts: [
      ''
    ]
    emailAccountAdmins: false
    emailAddresses: [
      ''
    ]
    retentionDays: 0
    state: 'Disabled'
  }
}

resource Microsoft_Sql_servers_sqlVulnerabilityAssessments_servers_wwi_migration_agrock86_name_Default 'Microsoft.Sql/servers/sqlVulnerabilityAssessments@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource Microsoft_Sql_servers_vulnerabilityAssessments_servers_wwi_migration_agrock86_name_Default 'Microsoft.Sql/servers/vulnerabilityAssessments@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'Default'
  properties: {
    recurringScans: {
      emailSubscriptionAdmins: true
      isEnabled: false
    }
    storageContainerPath: vulnerabilityAssessments_Default_storageContainerPath
  }
}

resource storageAccounts_wwimigrstdevagrock86_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccounts_wwimigrstdevagrock86_name_resource
  name: 'default'
  properties: {
    containerDeleteRetentionPolicy: {
      days: 7
      enabled: true
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      days: 7
      enabled: true
    }
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_wwimigrstdevagrock86_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storageAccounts_wwimigrstdevagrock86_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
    protocolSettings: {
      smb: {}
    }
    shareDeleteRetentionPolicy: {
      days: 7
      enabled: true
    }
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
}

resource storageAccounts_wwimigrstdevagrock86_name_storageAccounts_wwimigrstdevagrock86_name_39b39e63_3711_4cc3_b904_9418cd49ec6b 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2023-05-01' = {
  parent: storageAccounts_wwimigrstdevagrock86_name_resource
  name: '${storageAccounts_wwimigrstdevagrock86_name}.39b39e63-3711-4cc3-b904-9418cd49ec6b'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      actionRequired: 'None'
      description: 'Auto-Approved'
      status: 'Approved'
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_wwimigrstdevagrock86_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storageAccounts_wwimigrstdevagrock86_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_wwimigrstdevagrock86_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccounts_wwimigrstdevagrock86_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource bastionHosts_wwi_migration_bst_aflw_dev_name_resource 'Microsoft.Network/bastionHosts@2024-01-01' = {
  location: 'eastus'
  name: bastionHosts_wwi_migration_bst_aflw_dev_name
  properties: {
    disableCopyPaste: false
    dnsName: 'bst-e2a0479d-a5c6-4ba1-ae57-0efffeb60cd9.bastion.azure.com'
    enableIpConnect: true
    enableKerberos: false
    enableSessionRecording: false
    enableShareableLink: false
    enableTunneling: true
    ipConfigurations: [
      {
        id: '${bastionHosts_wwi_migration_bst_aflw_dev_name_resource.id}/bastionHostIpConfigurations/IpConf'
        name: 'IpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_wwi_migration_vm_aflw_dev_vnet_ip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_AzureBastionSubnet.id
          }
        }
      }
    ]
    scaleUnits: 2
  }
  sku: {
    name: 'Standard'
  }
}

resource networkInterfaces_wwi_migration_vm_aflw_dev251_name_resource 'Microsoft.Network/networkInterfaces@2024-01-01' = {
  kind: 'Regular'
  location: 'eastus'
  name: networkInterfaces_wwi_migration_vm_aflw_dev251_name
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
        id: '${networkInterfaces_wwi_migration_vm_aflw_dev251_name_resource.id}/ipConfigurations/ipconfig1'
        name: 'ipconfig1'
        properties: {
          primary: true
          privateIPAddress: '10.1.0.4'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_default2.id
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_wwimigrationvmaflwdevnsg858_name_resource.id
    }
    nicType: 'Standard'
  }
}

resource privateDnsZones_privatelink_azuredatabricks_net_name_qejhjdqwb4jqw 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_azuredatabricks_net_name_resource
  location: 'global'
  name: 'qejhjdqwb4jqw'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_wwi_migration_vnet_dev_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_database_windows_net_name_qejhjdqwb4jqw 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_database_windows_net_name_resource
  location: 'global'
  name: 'qejhjdqwb4jqw'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_wwi_migration_vnet_dev_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_dfs_core_windows_net_name_qejhjdqwb4jqw 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_dfs_core_windows_net_name_resource
  location: 'global'
  name: 'qejhjdqwb4jqw'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_wwi_migration_vnet_dev_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_vaultcore_azure_net_name_qejhjdqwb4jqw 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_vaultcore_azure_net_name_resource
  location: 'global'
  name: 'qejhjdqwb4jqw'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_wwi_migration_vnet_dev_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_azuredatabricks_net_name_qejhjdqwb4jqw1 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_azuredatabricks_net_name_resource
  location: 'global'
  name: 'qejhjdqwb4jqw1'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_resource.id
    }
  }
}

resource privateEndpoints_wwi_migration_pep_adb_dev_name_resource 'Microsoft.Network/privateEndpoints@2024-01-01' = {
  location: 'eastus'
  name: privateEndpoints_wwi_migration_pep_adb_dev_name
  properties: {
    customDnsConfigs: []
    customNetworkInterfaceName: '${privateEndpoints_wwi_migration_pep_adb_dev_name}-nic'
    ipConfigurations: []
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        id: '${privateEndpoints_wwi_migration_pep_adb_dev_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_wwi_migration_pep_adb_dev_name}'
        name: privateEndpoints_wwi_migration_pep_adb_dev_name
        properties: {
          groupIds: [
            'databricks_ui_api'
          ]
          privateLinkServiceConnectionState: {
            actionsRequired: 'None'
            description: 'Auto-approved'
            status: 'Approved'
          }
          privateLinkServiceId: workspaces_wwi_migration_v2_adb_dev_name_resource.id
        }
      }
    ]
    subnet: {
      id: virtualNetworks_wwi_migration_vnet_dev_name_default.id
    }
  }
}

resource privateEndpoints_wwi_migration_pep_kv_dev_name_resource 'Microsoft.Network/privateEndpoints@2024-01-01' = {
  location: 'eastus'
  name: privateEndpoints_wwi_migration_pep_kv_dev_name
  properties: {
    customDnsConfigs: []
    customNetworkInterfaceName: '${privateEndpoints_wwi_migration_pep_kv_dev_name}-nic'
    ipConfigurations: []
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        id: '${privateEndpoints_wwi_migration_pep_kv_dev_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_wwi_migration_pep_kv_dev_name}'
        name: privateEndpoints_wwi_migration_pep_kv_dev_name
        properties: {
          groupIds: [
            'vault'
          ]
          privateLinkServiceConnectionState: {
            actionsRequired: 'None'
            status: 'Approved'
          }
          privateLinkServiceId: vaults_wwi_migration_kv_dev_name_resource.id
        }
      }
    ]
    subnet: {
      id: virtualNetworks_wwi_migration_vnet_dev_name_default.id
    }
  }
}

resource privateEndpoints_wwi_migration_pep_msql_dev_name_resource 'Microsoft.Network/privateEndpoints@2024-01-01' = {
  location: 'eastus'
  name: privateEndpoints_wwi_migration_pep_msql_dev_name
  properties: {
    customDnsConfigs: []
    customNetworkInterfaceName: '${privateEndpoints_wwi_migration_pep_msql_dev_name}-nic'
    ipConfigurations: []
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        id: '${privateEndpoints_wwi_migration_pep_msql_dev_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_wwi_migration_pep_msql_dev_name}'
        name: privateEndpoints_wwi_migration_pep_msql_dev_name
        properties: {
          groupIds: [
            'sqlServer'
          ]
          privateLinkServiceConnectionState: {
            actionsRequired: 'None'
            description: 'Auto-approved'
            status: 'Approved'
          }
          privateLinkServiceId: servers_wwi_migration_agrock86_name_resource.id
        }
      }
    ]
    subnet: {
      id: virtualNetworks_wwi_migration_vnet_dev_name_default.id
    }
  }
}

resource privateEndpoints_wwi_migration_pep_st_dev_name_resource 'Microsoft.Network/privateEndpoints@2024-01-01' = {
  location: 'eastus'
  name: privateEndpoints_wwi_migration_pep_st_dev_name
  properties: {
    customDnsConfigs: []
    customNetworkInterfaceName: '${privateEndpoints_wwi_migration_pep_st_dev_name}-nic'
    ipConfigurations: []
    manualPrivateLinkServiceConnections: []
    privateLinkServiceConnections: [
      {
        id: '${privateEndpoints_wwi_migration_pep_st_dev_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_wwi_migration_pep_st_dev_name}'
        name: privateEndpoints_wwi_migration_pep_st_dev_name
        properties: {
          groupIds: [
            'dfs'
          ]
          privateLinkServiceConnectionState: {
            actionsRequired: 'None'
            description: 'Auto-Approved'
            status: 'Approved'
          }
          privateLinkServiceId: storageAccounts_wwimigrstdevagrock86_name_resource.id
        }
      }
    ]
    subnet: {
      id: virtualNetworks_wwi_migration_vnet_dev_name_default.id
    }
  }
}

resource privateEndpoints_wwi_migration_pep_adb_dev_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-01-01' = {
  name: '${privateEndpoints_wwi_migration_pep_adb_dev_name}/default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-azuredatabricks-net'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_azuredatabricks_net_name_resource.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoints_wwi_migration_pep_adb_dev_name_resource
  ]
}

resource privateEndpoints_wwi_migration_pep_kv_dev_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-01-01' = {
  name: '${privateEndpoints_wwi_migration_pep_kv_dev_name}/default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-vaultcore-azure-net'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_vaultcore_azure_net_name_resource.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoints_wwi_migration_pep_kv_dev_name_resource
  ]
}

resource privateEndpoints_wwi_migration_pep_msql_dev_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-01-01' = {
  name: '${privateEndpoints_wwi_migration_pep_msql_dev_name}/default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-database-windows-net'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_database_windows_net_name_resource.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoints_wwi_migration_pep_msql_dev_name_resource
  ]
}

resource privateEndpoints_wwi_migration_pep_st_dev_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2024-01-01' = {
  name: '${privateEndpoints_wwi_migration_pep_st_dev_name}/default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-dfs-core-windows-net'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_dfs_core_windows_net_name_resource.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoints_wwi_migration_pep_st_dev_name_resource
  ]
}

resource virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_resource 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  location: 'eastus'
  name: virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    enableDdosProtection: false
    subnets: [
      {
        id: virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_default2.id
        name: 'default2'
        properties: {
          addressPrefix: '10.1.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        id: virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_AzureBastionSubnet.id
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.1.1.0/26'
          delegations: []
          networkSecurityGroup: {
            id: networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_resource.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
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

resource virtualNetworks_wwi_migration_vnet_dev_name_resource 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  location: 'eastus'
  name: virtualNetworks_wwi_migration_vnet_dev_name
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
        id: virtualNetworks_wwi_migration_vnet_dev_name_default.id
        name: 'default'
        properties: {
          addressPrefixes: [
            '10.0.0.0/24'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: [
            {
              locations: [
                'eastus'
                'westus'
                'westus3'
              ]
              service: 'Microsoft.Storage'
            }
          ]
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        id: virtualNetworks_wwi_migration_vnet_dev_name_private_subnet.id
        name: 'private-subnet'
        properties: {
          addressPrefix: '10.179.0.0/18'
          delegations: [
            {
              id: '${virtualNetworks_wwi_migration_vnet_dev_name_private_subnet.id}/delegations/databricks-del-3khwjxg5525we'
              name: 'databricks-del-3khwjxg5525we'
              properties: {
                serviceName: 'Microsoft.Databricks/workspaces'
              }
              type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
            }
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: [
            {
              locations: [
                'eastus'
                'westus'
                'westus3'
              ]
              service: 'Microsoft.Storage'
            }
          ]
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
      {
        id: virtualNetworks_wwi_migration_vnet_dev_name_public_subnet.id
        name: 'public-subnet'
        properties: {
          addressPrefix: '10.179.64.0/18'
          delegations: [
            {
              id: '${virtualNetworks_wwi_migration_vnet_dev_name_public_subnet.id}/delegations/databricks-del-dgrsc2efy4ncg'
              name: 'databricks-del-dgrsc2efy4ncg'
              properties: {
                serviceName: 'Microsoft.Databricks/workspaces'
              }
              type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
            }
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: [
            {
              locations: [
                'eastus'
                'westus'
                'westus3'
              ]
              service: 'Microsoft.Storage'
            }
          ]
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
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

resource virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name}/AzureBastionSubnet'
  properties: {
    addressPrefix: '10.1.1.0/26'
    delegations: []
    networkSecurityGroup: {
      id: networkSecurityGroups_wwimigrationvmaflwdevnsg859_name_resource.id
    }
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_resource
  ]
}

resource virtualNetworks_wwi_migration_vnet_dev_name_private_subnet 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${virtualNetworks_wwi_migration_vnet_dev_name}/private-subnet'
  properties: {
    addressPrefix: '10.179.0.0/18'
    delegations: [
      {
        id: '${virtualNetworks_wwi_migration_vnet_dev_name_private_subnet.id}/delegations/databricks-del-3khwjxg5525we'
        name: 'databricks-del-3khwjxg5525we'
        properties: {
          serviceName: 'Microsoft.Databricks/workspaces'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource.id
    }
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpoints: [
      {
        locations: [
          'eastus'
          'westus'
          'westus3'
        ]
        service: 'Microsoft.Storage'
      }
    ]
  }
  dependsOn: [
    virtualNetworks_wwi_migration_vnet_dev_name_resource
  ]
}

resource virtualNetworks_wwi_migration_vnet_dev_name_public_subnet 'Microsoft.Network/virtualNetworks/subnets@2024-01-01' = {
  name: '${virtualNetworks_wwi_migration_vnet_dev_name}/public-subnet'
  properties: {
    addressPrefix: '10.179.64.0/18'
    delegations: [
      {
        id: '${virtualNetworks_wwi_migration_vnet_dev_name_public_subnet.id}/delegations/databricks-del-dgrsc2efy4ncg'
        name: 'databricks-del-dgrsc2efy4ncg'
        properties: {
          serviceName: 'Microsoft.Databricks/workspaces'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_databricksnsglw47yhy3wcrcs_name_resource.id
    }
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpoints: [
      {
        locations: [
          'eastus'
          'westus'
          'westus3'
        ]
        service: 'Microsoft.Storage'
      }
    ]
  }
  dependsOn: [
    virtualNetworks_wwi_migration_vnet_dev_name_resource
  ]
}

resource virtualNetworks_wwi_migration_vnet_dev_name_wwi_migration_vnetp_aflw_dev 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-01-01' = {
  name: '${virtualNetworks_wwi_migration_vnet_dev_name}/wwi-migration-vnetp-aflw-dev'
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
  dependsOn: [
    virtualNetworks_wwi_migration_vnet_dev_name_resource
  ]
}

resource virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_wwi_migration_vnetp_dev 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-01-01' = {
  name: '${virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name}/wwi-migration-vnetp-dev'
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
  dependsOn: [
    virtualNetworks_wwi_migration_vm_aflw_dev_vnet_name_resource
  ]
}

resource servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource servers_wwi_migration_agrock86_name_WideWorldImporters_CreateIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'CreateIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource servers_wwi_migration_agrock86_name_WideWorldImporters_DbParameterization 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'DbParameterization'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource servers_wwi_migration_agrock86_name_WideWorldImporters_DefragmentIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'DefragmentIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource servers_wwi_migration_agrock86_name_WideWorldImporters_DropIndex 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'DropIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource servers_wwi_migration_agrock86_name_WideWorldImporters_ForceLastGoodPlan 'Microsoft.Sql/servers/databases/advisors@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'ForceLastGoodPlan'
  properties: {
    autoExecuteValue: 'Enabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingPolicies_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  location: 'East US'
  name: 'Default'
  properties: {
    auditingState: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingSettings_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/auditingSettings@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'default'
  properties: {
    isAzureMonitorTargetEnabled: false
    retentionDays: 0
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_backupLongTermRetentionPolicies_servers_wwi_migration_agrock86_name_WideWorldImporters_default 'Microsoft.Sql/servers/databases/backupLongTermRetentionPolicies@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'default'
  properties: {
    monthlyRetention: 'PT0S'
    weekOfYear: 0
    weeklyRetention: 'PT0S'
    yearlyRetention: 'PT0S'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_backupShortTermRetentionPolicies_servers_wwi_migration_agrock86_name_WideWorldImporters_default 'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'default'
  properties: {
    diffBackupIntervalInHours: 12
    retentionDays: 7
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_extendedAuditingSettings_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'default'
  properties: {
    isAzureMonitorTargetEnabled: false
    retentionDays: 0
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_geoBackupPolicies_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource servers_wwi_migration_agrock86_name_WideWorldImporters_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'Current'
  properties: {}
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_securityAlertPolicies_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'Default'
  properties: {
    disabledAlerts: [
      ''
    ]
    emailAccountAdmins: false
    emailAddresses: [
      ''
    ]
    retentionDays: 0
    state: 'Disabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_transparentDataEncryption_servers_wwi_migration_agrock86_name_WideWorldImporters_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'Current'
  properties: {
    state: 'Enabled'
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_servers_wwi_migration_agrock86_name_WideWorldImporters_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_WideWorldImporters
  name: 'Default'
  properties: {
    recurringScans: {
      emailSubscriptionAdmins: true
      isEnabled: false
    }
  }
  dependsOn: [
    servers_wwi_migration_agrock86_name_resource
  ]
}

resource servers_wwi_migration_agrock86_name_wwi_migration_pep_msql_dev_8ab9bda1_e836_4250_ba42_00804cbba97f 'Microsoft.Sql/servers/privateEndpointConnections@2023-08-01-preview' = {
  parent: servers_wwi_migration_agrock86_name_resource
  name: 'wwi-migration-pep-msql-dev-8ab9bda1-e836-4250-ba42-00804cbba97f'
  properties: {
    privateEndpoint: {
      id: privateEndpoints_wwi_migration_pep_msql_dev_name_resource.id
    }
    privateLinkServiceConnectionState: {
      description: 'Auto-approved'
      status: 'Approved'
    }
  }
}

resource storageAccounts_wwimigrstdevagrock86_name_default_dwh 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_wwimigrstdevagrock86_name_default
  name: 'dwh'
  properties: {
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    immutableStorageWithVersioning: {
      enabled: false
    }
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_wwimigrstdevagrock86_name_resource
  ]
}

resource storageAccounts_wwimigrstdevagrock86_name_resource 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  kind: 'StorageV2'
  location: 'eastus'
  name: storageAccounts_wwimigrstdevagrock86_name
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    allowCrossTenantReplication: false
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'Standard'
    encryption: {
      keySource: 'Microsoft.Storage'
      requireInfrastructureEncryption: false
      services: {
        blob: {
          enabled: true
          keyType: 'Account'
        }
        file: {
          enabled: true
          keyType: 'Account'
        }
      }
    }
    isHnsEnabled: true
    isSftpEnabled: false
    largeFileSharesState: 'Enabled'
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: []
      resourceAccessRules: [
        {
          resourceId: accessConnectors_externalid
          tenantId: '5f751a8a-2fcf-4979-9e68-b20f298c27ba'
        }
      ]
      virtualNetworkRules: [
        {
          action: 'Allow'
          id: virtualNetworks_wwi_migration_vnet_dev_name_default.id
          state: 'Succeeded'
        }
        {
          action: 'Allow'
          id: virtualNetworks_wwi_migration_vnet_dev_name_private_subnet.id
          state: 'Succeeded'
        }
        {
          action: 'Allow'
          id: virtualNetworks_wwi_migration_vnet_dev_name_public_subnet.id
          state: 'Succeeded'
        }
      ]
    }
    publicNetworkAccess: 'Disabled'
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
}
