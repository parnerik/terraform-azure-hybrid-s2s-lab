resource "azurerm_virtual_network" "hybrid" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.hybrid.location
  resource_group_name = azurerm_resource_group.hybrid.name
}

resource "azurerm_subnet" "servers" {
  name                 = var.servers_subnet_name
  resource_group_name  = azurerm_resource_group.hybrid.name
  virtual_network_name = azurerm_virtual_network.hybrid.name
  address_prefixes     = [var.servers_subnet_address_prefix]

  default_outbound_access_enabled = false
}

resource "azurerm_subnet" "identity" {
  name                 = var.identity_subnet_name
  resource_group_name  = azurerm_resource_group.hybrid.name
  virtual_network_name = azurerm_virtual_network.hybrid.name
  address_prefixes     = [var.identity_subnet_address_prefix]

  default_outbound_access_enabled = false
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hybrid.name
  virtual_network_name = azurerm_virtual_network.hybrid.name
  address_prefixes     = [var.gateway_subnet_address_prefix]
}
