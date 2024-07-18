resource "azurerm_network_interface_security_group_association" "this" {
  count                     = var.azurerm_vm_count
  network_interface_id      = azurerm_network_interface.this[count.index].id
  network_security_group_id = azurerm_network_security_group.this.id
}
#