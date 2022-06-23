resource "azurerm_virtual_network_peering" "vpn_to_infrastructure" {
  name                      = "vpn_to_infrastructure"
  resource_group_name       = var.resource_group_vpn_name
  virtual_network_name      = var.vnet_vpn_name
  remote_virtual_network_id = azurerm_virtual_network.vnet_infrastructure.id
  allow_gateway_transit = true
  allow_forwarded_traffic = true
}

resource "azurerm_virtual_network_peering" "infrastructure_to_vpn" {
  name                      = "infrastructure_to_vpn"
  resource_group_name       = var.resource_group_inf_name
  virtual_network_name      = var.vnet_inf_name
  remote_virtual_network_id = azurerm_virtual_network.vnet_vpn.id
  allow_forwarded_traffic = true
  use_remote_gateways = true
}