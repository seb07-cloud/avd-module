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
