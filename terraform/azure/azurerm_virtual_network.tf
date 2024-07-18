resource "azurerm_virtual_network" "this" {
    name                = var.azurerm_virtual_network_name
    resource_group_name = var.azurerm_resource_group_name
    location            = var.azure_primary_region
    address_space       = var.azurerm_virtual_network_address_space
}
#