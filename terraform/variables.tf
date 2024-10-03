variable "vm" {
  type = map(
    object(
      {
        vm_name                = string,
        vm_id                  = number,
        proxmox_node_name      = string,
        vm_description         = string,
        ipv4_address           = string,
        ipv4_gateway           = string,
        architecture           = string,
        cores                  = number,
        host_type              = string,
        memory                 = number,
        keyboard_layout        = string,
        vga_memory             = number,
        vga_type               = string,
        network_device_bridge  = string,
        network_device_enabled = bool,
        operating_system_type  = string,
        reboot                 = bool,
        disk_in_gb             = number
      }
    )
  )
  description = "vm object"
  sensitive   = false
}
#
variable "ssh_public_key_file" {
  type        = string
  description = "SSH Public Key file and path"
  sensitive   = false
}
#
variable "username" {
  type        = string
  description = "username for the VM"
  sensitive   = false
}
#
variable "proxmox_username" {
  type        = string
  description = "Proxmox user name"
  sensitive   = false
}
#
variable "proxmox_endpoint" {
  type        = string
  description = "Proxmox endpoint URL"
  sensitive   = false
}
#
variable "password" {
  type        = string
  description = "password for the user of the VM"
  sensitive   = true
}
#
variable "proxmox_password" {
  type        = string
  description = "Proxmox password"
  sensitive   = true
}
#
variable "cloud_image_url" {
  type        = string
  description = "URL of the cloud image to be downloaded"
  sensitive   = false
}
#
variable "cloud_image_file_name" {
  type        = string
  description = "file name of the cloud image"
  sensitive   = false
}
#
variable "proxmox_tags" {
  type        = list(string)
  description = "List of tags for the proxmox vms to be created"
  sensitive   = false
}
#
