variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space of the virtual network"
  type        = string
}

variable "servers_subnet_address_prefix" {
  description = "The address prefix of the servers subnet"
  type        = string
}

variable "servers_subnet_name" {
  description = "The name of the servers subnet"
  type        = string
}

variable "identity_subnet_name" {
  description = "The name of the identity subnet"
  type        = string
}

variable "identity_subnet_address_prefix" {
  description = "The address prefix of the identity subnet"
  type        = string
}

variable "gateway_subnet_address_prefix" {
  description = "The address prefix of the gateway subnet"
  type        = string
}

variable "vpn_gateway_public_ip_name" {
  description = "The name of the VPN gateway public IP"
  type        = string
}

variable "vpn_gateway_name" {
  description = "The name of the VPN gateway"
  type        = string
}

variable "local_network_gateway_name" {
  description = "The name of the local network gateway"
  type        = string
}

variable "onpremises_vpn_public_ip" {
  description = "The public IP address of the on-premises VPN device"
  type        = string
}

variable "onpremises_vpn_address_space" {
  description = "The address space of the on-premises network"
  type        = string
}

variable "s2s_vpn_connection_name" {
  description = "The name of the site-to-site VPN connection"
  type        = string
}

variable "s2s_vpn_connection_shared_key" {
  description = "The shared key for the site-to-site VPN connection"
  type        = string
  sensitive   = true
}

variable "dc02_nic_name" {
  description = "The name of the az-dc02 NIC"
  type        = string
}

variable "dc02_private_ip_address" {
  description = "The private IP address of az-dc02"
  type        = string
}

variable "dc02_vm_name" {
  description = "The name of the az-dc02 VM"
  type        = string
}

variable "dc02_dns_server" {
  description = "The DNS server IP used by az-dc02"
  type        = string
}

variable "dc02_admin_username" {
  description = "The admin username for az-dc02"
  type        = string
}

variable "dc02_admin_password" {
  description = "The admin password for az-dc02"
  type        = string
  sensitive   = true
}

variable "dc02_vm_size" {
  description = "The size of the az-dc02 VM"
  type        = string
}

variable "dc02_image_publisher" {
  description = "The image publisher for az-dc02"
  type        = string
}

variable "dc02_image_offer" {
  description = "The image offer for az-dc02"
  type        = string
}

variable "dc02_image_sku" {
  description = "The image SKU for az-dc02"
  type        = string
}

variable "dc02_image_version" {
  description = "The version of the az-dc02 image"
  type        = string
}

variable "nat_gateway_public_ip_name" {
  description = "The name of the NAT Gateway public IP"
  type        = string
}

variable "nat_gateway_name" {
  description = "The name of the NAT Gateway"
  type        = string
}


