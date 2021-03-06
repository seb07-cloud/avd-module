locals {
  expiration_date = time_rotating.avd_token.rotation_rfc3339
}

resource "azurerm_virtual_desktop_host_pool" "avd_hp" {

  count = var.avd_hostpool_count

  location            = var.resourcegroup_location
  resource_group_name = var.avd_resourcegroup_name

  name                     = "hp_${lower(var.avd_hostpool_type)}_${lower(var.customer_prefix)}_${count.index}"
  friendly_name            = "${upper(var.customer_prefix)}-hostpool-${count.index}"
  validate_environment     = false
  start_vm_on_connect      = true
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;targetisaadjoined:i:1;"
  description              = "${upper(var.customer_prefix)}-hostpool-${count.index}"
  type                     = var.avd_hostpool_type
  maximum_sessions_allowed = 15
  load_balancer_type       = var.load_balancer_type
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo" {

  count = var.avd_hostpool_count

  hostpool_id     = azurerm_virtual_desktop_host_pool.avd_hp.*.id[count.index]
  expiration_date = local.expiration_date
}

resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "${upper(var.customer_prefix)}-Workspace"
  location            = var.resourcegroup_location
  resource_group_name = var.avd_resourcegroup_name
  friendly_name       = "${upper(var.customer_prefix)}-Workspace"
  description         = "${upper(var.customer_prefix)}-Workspace"
}

resource "azurerm_virtual_desktop_application_group" "desktopapp" {

  count = var.avd_hostpool_count

  name                = "${upper(var.customer_prefix)}-Desktop-${count.index}"
  location            = var.resourcegroup_location
  resource_group_name = var.avd_resourcegroup_name
  type                = "Desktop"
  host_pool_id        = azurerm_virtual_desktop_host_pool.avd_hp.*.id[count.index]
  friendly_name       = "Applications"
  description         = "Desktop Application for AVD"
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "workspaceremoteapp" {

  count = var.avd_hostpool_count

  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
  application_group_id = azurerm_virtual_desktop_application_group.desktopapp.*.id[count.index]
}



output "hostpool_name" {
  value = ["${azurerm_virtual_desktop_host_pool.avd_hp.*.name}"]
  depends_on = [
    azurerm_virtual_desktop_host_pool.avd_hp
  ]

}
output "workspace_name" {
  value = ["${azurerm_virtual_desktop_workspace.workspace.*.name}"]
  depends_on = [
    azurerm_virtual_desktop_workspace.workspace
  ]
}

output "registration_info_token" {
  value = ["${azurerm_virtual_desktop_host_pool_registration_info.*.registrationinfo.token}"]
}
