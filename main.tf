terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.2.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg_terraformstate"
    storage_account_name = "nyzeterraformtfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
}

resource "time_rotating" "avd_token" {
  rotation_days = 27
}

resource "random_string" "string" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

resource "azurerm_resource_group" "rg_infra" {
  name     = "rg_infra"
  location = var.resourcegroup_location
}

resource "azurerm_resource_group" "rg_avd" {
  name     = "rg_avd"
  location = var.resourcegroup_location
}

module "network" {
  for_each               = var.vnets
  source                 = "./modules/network"
  resourcegroup_name     = azurerm_resource_group.rg_infra.name
  resourcegroup_location = azurerm_resource_group.rg_infra.location
  vnet_name              = "vnet_${each.key}"
  vnet_address_space     = each.value["vnet_net"]
  vnet_sn_name           = "sn_${each.key}_vnet_${each.key}"
  vnet_subnet_address    = each.value["snet_net"]
  vnet_nsg_name          = "nsg_${each.key}_vnet_${each.key}"
  dns_servers            = var.dns_servers
}

module "sessionhosts" {
  avd_sessionhost_count      = var.avd_sessionhost_count
  source                     = "./modules/sessionhosts"
  customer_prefix            = var.customer_prefix
  environment                = var.environment
  avd_sessionhost_prefix     = var.avd_sessionhost_prefix
  sn_avd_name                = var.sn_avd_name
  vm_size                    = var.vm_size
  admin_user                 = var.admin_user
  admin_password             = random_string.string.result
  resourcegroup_name         = azurerm_resource_group.rg_avd.name
  resourcegroup_location     = azurerm_resource_group.rg_avd.location
  desktop_vm_image_publisher = var.desktop_vm_image_publisher
  desktop_vm_image_offer     = var.desktop_vm_image_offer
  desktop_vm_image_sku       = var.desktop_vm_image_sku
  desktop_vm_image_version   = var.desktop_vm_image_version
  avd_workspace_name         = "${upper(var.customer_prefix)}-Workspace"
  avd_hostpool_name          = "hp_${lower(var.avd_hostpool_type)}_${lower(var.customer_prefix)}_${count.index}"
  resourcegroup_avd_id       = azurerm_resource_group.rg_avd.id
  registration_info_token    = var.registration_info_token
}
