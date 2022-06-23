#Resourcegroup config 
resource_groups        = ["rg_infra", "rg_avd"]
resourcegroup_location = "westeurope"
environment            = "PROD"

#Name vnets / networks
vnets = {
  infra = {
    vnet_net = ["10.125.0.0/16"],
    snet_net = ["10.125.1.0/24"]
  },
  avd = {
    vnet_net = ["10.126.0.0/16"],
    snet_net = ["10.126.1.0/24"]
  },
  data = {
    vnet_net = ["10.127.0.0/16"],
    snet_net = ["10.127.1.0/24"]
  }
  vpn = {
    vnet_net = ["10.127.0.0/16"],
    snet_net = ["10.127.1.0/24"]
  }
}

#DNS Server for Vnet`s
dns_servers = ["10.0.0.1", "10.0.0.2"]

#VPN Config
resource_group_inf_name = "rg_infra"
resource_group_vpn_name = "rg_vpn"
vnet_vpn_name           = "vnet_vpn"
vnet_inf_name           = "vnet_infra"
vpn_psk                 = ""
gateway_sn              = ""
onpremvpngwip           = ""
onpremsubnet            = ""

#Customer prefix
customer_prefix = "dyna"

#Sessionhost config
admin_user             = "dynadm"
vm_size                = "Standard_D4s_v4"
avd_sessionhost_prefix = "avd"
avd_sessionhost_count  = 2
sn_avd_name            = "sn_avd_vnet_avd"
avd_resourcegroup_name = "rg_avd"
expiration_date        = time_rotating.avd_token.rotation_rfc3339

#Image config
desktop_vm_image_publisher = "MicrosoftWindowsDesktop"
desktop_vm_image_offer     = "Windows-11"
desktop_vm_image_sku       = "win11-21h2-avd"
desktop_vm_image_version   = "latest"

#Hostpool settings
max_sessions_per_hostpool = 15
load_balancer_type        = "DepthFirst"
avd_hostpool_type         = "Pooled"
avd_hostpool_count        = 2

## Assign to group
aad_group_name = "gr_AVD-Users"
