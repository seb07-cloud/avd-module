variable "resourcegroup_name" {
  type = string
}
variable "resourcegroup_location" {
  type = string
}
variable "vnet_name" {
  type        = string
  description = "What is the VNETs name"
}
variable "vnet_address_space" {
  type        = list(any)
  description = "What is the VNETs addresspace"
}
variable "vnet_sn_name" {
  type        = string
  description = "sn name"
}
variable "vnet_subnet_address" {
  type        = list(any)
  description = "What is the subnet addresspace"
}
variable "vnet_nsg_name" {
  type        = string
  description = "Network security group name"
}
