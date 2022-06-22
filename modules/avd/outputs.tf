output "hostpool_name" {
  value = azurerm_virtual_desktop_host_pool.avd_hp.name
  depends_on = [
    azurerm_virtual_desktop_host_pool.avd_hp
  ]

}
output "workspace_name" {
  value = azurerm_virtual_desktop_workspace.workspace.name
  depends_on = [
    azurerm_virtual_desktop_workspace.workspace
  ]
}
