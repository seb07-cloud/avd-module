variable "vnets" {
  type = map(any)
}
variable "resource_groups" {
  type = list(string)
}
variable "customer_prefix" {
  type = string
}
variable "resourcegroup_location" {
  type = string
}
variable "max_sessions_per_hostpool" {
  type = number
}
variable "load_balancer_type" {
  type = string
}
variable "avd_hostpool_type" {
  type = string
}
variable "avd_hostpool_count" {
  type = number
}
variable "avd_sessionhost_count" {
  type = number
}
variable "aad_group_name" {
  type = string
}
variable "admin_user" {
  type = string
}
variable "vm_size" {
  type = string
}
variable "avd_sessionhost_prefix" {
  type = string
}
variable "desktop_vm_image_publisher" {
  type        = string
  description = "Windows 10"
}
variable "desktop_vm_image_offer" {
  type        = string
  description = "Windows 10"
}
variable "desktop_vm_image_sku" {
  type        = string
  description = "Windows 10 20H2 Image SKU"
}
variable "desktop_vm_image_version" {
  type        = string
  description = "Latest Version"
}
variable "sn_avd_name" {
  type = string
}
variable "dns_servers" {
  type = list(any)
}
variable "resource_group_inf_name" {
 type = string 
}
variable "resource_group_vpn_name" {
  type = string
}
variable "vnet_vpn_name" {
  type = string
}
variable "vnet_inf_name" {
  type = string
}
variable "vpn_psk" {
  type = string
}
variable "gateway_sn" {
  type = string
}
variable "onpremvpngwip" {
  type = string
}
variable "onpremsubnet" {
  type = list(string)
}
variable "avd_workspace_name" {
  type = string
}
variable "avd_resourcegroup_name" {
  type = string
}
variable "avd_hostpool_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "expiration_date" {
  type = string
}
variable "registration_info_token" {
  type = string
}