resource "azurerm_resource_group" "hybrid" {
  name     = var.resource_group_name
  location = var.location
}