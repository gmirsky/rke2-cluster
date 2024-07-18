resource "azurerm_linux_virtual_machine" "this" {
  count               = var.azurerm_vm_count
  name                = "rke2-${count.index + 1}"
  resource_group_name = var.azurerm_resource_group_name
  location            = var.azure_primary_region
  network_interface_ids = [
    azurerm_network_interface.this[count.index].id
  ]
  size = "Standard_DS1_v2"
  os_disk {
    name                 = "osdisk-${count.index + 1}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  computer_name  = "rke2-${count.index + 1}"
  admin_username = var.vm_admin_username
  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.this[count.index].primary_blob_endpoint
  }
}
