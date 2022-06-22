resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  resource_group_name = var.resourcegroup_name
  location            = var.resourcegroup_location
}

resource "azurerm_virtual_network_dns_servers" "vnet" {
  virtual_network_id = azurerm_virtual_network.vnet.id
  dns_servers        = var.dns_servers
}

resource "azurerm_subnet" "sn" {
  name                 = var.vnet_sn_name
  resource_group_name  = var.resourcegroup_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.vnet_subnet_address
}

## NSG Config
resource "azurerm_network_security_group" "nsg" {
  name                = var.vnet_nsg_name
  resource_group_name = var.resourcegroup_name
  location            = var.resourcegroup_location
  security_rule {
    name                       = "allow-rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 3389
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# Create NSG Assoc
resource "azurerm_subnet_network_security_group_association" "nsg_association-inf" {
  subnet_id                 = azurerm_subnet.sn.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
