resource "azurerm_subnet" "this" {
  name = var.azurerm_subnet_name
    resource_group_name = var.azurerm_resource_group_name
    virtual_network_name = azurerm_virtual_network.this.name
    address_prefixes = var.azurerm_subnet_address_prefixes
}