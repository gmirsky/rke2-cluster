resource "proxmox_virtual_environment_vm" "this" {
  count       = local.server_count
  name        = var.vm[(keys(var.vm))[count.index]].vm_name
  vm_id       = var.vm[(keys(var.vm))[count.index]].vm_id
  node_name   = var.vm[(keys(var.vm))[count.index]].proxmox_node_name
  description = "(${count.index + 1} of ${local.server_count}) ${var.vm[(keys(var.vm))[count.index]].vm_description}"
  tags        = var.proxmox_tags
  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = false
  }
  initialization {
    #vendor_data_file_id = proxmox_virtual_environment_file.hook_script[count.index].id
    user_account {
      username = var.username
      password = var.password
      keys = [
        data.local_file.ssh_public_key.content
      ]
    }
    ip_config {
      ipv4 {
        address = var.vm[(keys(var.vm))[count.index]].ipv4_address
        gateway = var.vm[(keys(var.vm))[count.index]].ipv4_gateway
      }
    }
  }
  stop_on_destroy = true
  disk {
    datastore_id = "cephpool1"
    file_id      = proxmox_virtual_environment_download_file.this[count.index].id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.vm[(keys(var.vm))[count.index]].disk_in_gb
  }
  cpu {
    architecture = var.vm[(keys(var.vm))[count.index]].architecture
    cores        = var.vm[(keys(var.vm))[count.index]].cores
    type         = "host"
  }
  memory {
    dedicated = var.vm[(keys(var.vm))[count.index]].memory
  }
  keyboard_layout = var.vm[(keys(var.vm))[count.index]].keyboard_layout
  vga {
    memory = var.vm[(keys(var.vm))[count.index]].vga_memory
    type   = var.vm[(keys(var.vm))[count.index]].vga_type
  }
  network_device {
    bridge  = var.vm[(keys(var.vm))[count.index]].network_device_bridge
    enabled = var.vm[(keys(var.vm))[count.index]].network_device_enabled
  }
  operating_system {
    type = var.vm[(keys(var.vm))[count.index]].operating_system_type
  }
  reboot = var.vm[(keys(var.vm))[count.index]].reboot
}
#
