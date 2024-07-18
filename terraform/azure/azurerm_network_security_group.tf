resource "azurerm_network_security_group" "this" {
  name                = var.azurerm_network_security_group_name
  location            = var.azure_primary_region
  resource_group_name = var.azurerm_resource_group_name
}