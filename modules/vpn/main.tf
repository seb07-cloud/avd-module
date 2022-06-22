#Vnet Config
resource "azurerm_virtual_network" "vnet_vpn" {
    name                = "vnet_vpn"
    address_space       = var.vnet_vpn
    location            = var.resource_group_location
    resource_group_name = var.resource_group_vpn_name
}

resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_vpn_name
  virtual_network_name = var.vnet_vpn_name
  address_prefixes     = var.gateway_sn
}

resource "azurerm_virtual_network_dns_servers" "vnet_vpn" {
  virtual_network_id = azurerm_virtual_network.vnet_vpn.id
  dns_servers        = var.dns_servers
}

resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_vpn_name
  virtual_network_name = var.vnet_vpn_name
  address_prefixes     = var.gateway_sn
}

# Gateway Config
resource "azurerm_public_ip" "pip_vpngw_vnetg_infrastructure_vpngw" {
  name                = "pip_vpngw_vnetg_infrastructure_vpngw"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_vpn_name
  allocation_method   = "Dynamic"
}


resource "azurerm_var_network_gateway" "ln_gw_onpremise" {
  name                = "ln_gw_onpremise"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_vpn_name
  gateway_address     = var.onpremvpngwip
  address_space       = var.onpremsubnet
}

resource "azurerm_virtual_network_gateway" "vpngw_vnetg_infrastructure_vpngw" {
  name                = "vpngw_vnetg_infrastructure_vpngw"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_vpn_name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1"

  active_active = false
  enable_bgp    = false
  

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.pip_vpngw_vnetg_infrastructure_vpngw.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.GatewaySubnet.id
  }
}

resource "azurerm_virtual_network_gateway_connection" "lw_gw_conn_onpremise" {
  name                = "lw_gw_conn_onpremise"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_vpn_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpngw_vnetg_infrastructure_vpngw.id
  var_network_gateway_id   = azurerm_var_network_gateway.ln_gw_onpremise.id

  shared_key = var.vpn_psk
  connection_protocol = "IKEv1"

  ipsec_policy {
    dh_group = "DHGroup14"
    ike_encryption = "AES256"
    ike_integrity = "SHA256"
    ipsec_encryption = "AES256"
    ipsec_integrity = "SHA256"
    pfs_group = "PFS2048"
    sa_lifetime = "86400"
    sa_datasize = "10485760"
  } 
}