resource "azurerm_public_ip" "nat_gateway" {
  name                = var.nat_gateway_public_ip_name
  location            = azurerm_resource_group.hybrid.location
  resource_group_name = azurerm_resource_group.hybrid.name

  allocation_method = "Static"
  sku               = "Standard"
}

resource "azurerm_nat_gateway" "hybrid" {
  name                = var.nat_gateway_name
  location            = azurerm_resource_group.hybrid.location
  resource_group_name = azurerm_resource_group.hybrid.name

  sku_name = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "hybrid" {
  nat_gateway_id       = azurerm_nat_gateway.hybrid.id
  public_ip_address_id = azurerm_public_ip.nat_gateway.id
}

resource "azurerm_subnet_nat_gateway_association" "identity" {
  subnet_id      = azurerm_subnet.identity.id
  nat_gateway_id = azurerm_nat_gateway.hybrid.id
}

resource "azurerm_subnet_nat_gateway_association" "servers" {
  subnet_id      = azurerm_subnet.servers.id
  nat_gateway_id = azurerm_nat_gateway.hybrid.id

}