resource "azurerm_network_interface" "this" {
  count               = var.azurerm_vm_count
  name                = "${var.azurerm_network_interface_prefix}-${count.index+1}"
  location            = var.azure_primary_region
  resource_group_name = var.azurerm_resource_group_name
  ip_configuration {
    name                          = "internal-${count.index}"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.${count.index+1}"
  }
}
#