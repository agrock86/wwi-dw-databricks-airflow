targetScope = 'subscription'

param deployment_id string
param default_location string
param project string
param env string
@secure()
param admin_password string
param client_ip string

var admin_login = 'sys_admin'

// common resource group with shared resources.
resource rg_common 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: 'common-rg-${env}'
}

// project resource group.
resource rg_main 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${project}-rg-main-${env}'
  location: default_location
}

module dply_main_rg 'main_rg.bicep' = {
  name: '${project}-dply-main-rg-${deployment_id}-${env}'
  scope: rg_main
  params: {
    project: project
    env: env
  }
}

// configures the common resource group with project scoped resources.
module dply_common_rg 'common_rg.bicep' = {
  name: '${project}-dply-common-rg-${deployment_id}-${env}'
  scope: rg_common
  params: {
    uami_admin: dply_main_rg.outputs.uami_admin
  }
}

module dply_main_vnet './main_vnet.bicep' = {
  name: '${project}-dply-main-vnet-${deployment_id}-${env}'
  scope: rg_main
  params: {
    project: project
    env: env
  }
}

module dply_oltp_db './oltp_db.bicep' = {
  name: '${project}-dply-oltp-db-${deployment_id}-${env}'
  scope: rg_main
  params: {
    project: project
    env: env
    admin_login: admin_login
    admin_password: admin_password
    client_ip: client_ip
  }
}

module dply_common_backup_st 'common_backup_st.bicep' = {
  name: '${project}-dply-common-backup-st-${deployment_id}-${env}'
  scope: rg_common
  params: {
    env: env
  }
}

module dply_oltp_db_restore './oltp_db_restore.bicep' = {
  name: '${project}-dply-oltp-db-restore-${deployment_id}-${env}'
  scope: rg_main
  params: {
    project: project
    env: env
    admin_login: admin_login
    admin_password: admin_password
    sqlsrv_wwi_oltp: dply_oltp_db.outputs.sqlsrv_wwi_oltp
    sqldb_wwi_oltp: dply_oltp_db.outputs.sqldb_wwi_oltp
    uami_admin: dply_main_rg.outputs.uami_admin
    st_backup: dply_common_backup_st.outputs.st_backup
  }
}

module dply_airflow_vm './airflow_vm.bicep' = {
  name: '${project}-dply-airflow-vm-${deployment_id}-${env}'
  scope: rg_main
  params: {
    project: project
    env: env
    admin_login: admin_login
    admin_password: admin_password
    vnet_main: dply_main_vnet.outputs.vnet_main
  }
}

//TO-DO: make the Azure SQL Server private after deployment
