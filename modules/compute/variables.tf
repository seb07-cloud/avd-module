variable "resourcegroup_name" {
  type = string
}
variable "resourcegroup_location" {
  type = string
}
variable "vm_size" {
  type = string
}
variable "admin_user" {
  type = string
}
variable "admin_password" {
  type = string
}
variable "customer_prefix" {
  type = string
}
variable "avd_sessionhost_prefix" {
  type = string
}
variable "avd_sessionhost_count" {
  type = number
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
