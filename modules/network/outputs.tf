output "vnet_name_out" {
  value = ["${azurerm_virtual_network.vnet.*.name}"]
}
output "vnet_id_out" {
  value = ["${azurerm_virtual_network.vnet.*.id}"]
}
