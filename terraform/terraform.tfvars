cloud_image_file_name = "rocky_9_latest_generic_cloud.img"
cloud_image_url       = "http://dl.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-GenericCloud.latest.x86_64.qcow2"
password              = "****************" # replace with your password.
proxmox_endpoint      = "https://192.168.1.201:8006/"
proxmox_password      = "****************" # replace with your password.
proxmox_username      = "root@pam"
ssh_public_key_file   = "/home/gmirsky/.ssh/id_rsa.pub" #replace with your ssh public key file.
username              = "gmirsky" #replace with the ID you want provisioned on your servers.
proxmox_tags = [
  "kubernetes",
  "linux",
  "rocky9",
  "terraform",
  "development"
]
#
vm = {
  vm1 = {
    vm_name                = "vm1",
    vm_id                  = 401,
    proxmox_node_name      = "pve1",
    vm_description         = "Rocky Linux 9 VM",
    ipv4_address           = "192.168.1.211/24",
    ipv4_gateway           = "192.168.1.1",
    architecture           = "x86_64",
    cores                  = 6,
    host_type              = "x86-64-v2-AES",
    memory                 = 8192,
    keyboard_layout        = "en-us",
    vga_memory             = 16,
    vga_type               = "virtio",
    network_device_bridge  = "vmbr0",
    network_device_enabled = true,
    operating_system_type  = "l26",
    reboot                 = false,
    disk_in_gb             = 75
  }
  vm2 = {
    vm_name                = "vm2",
    vm_id                  = 402,
    proxmox_node_name      = "pve2",
    vm_description         = "Rocky Linux 9 VM",
    ipv4_address           = "192.168.1.212/24",
    ipv4_gateway           = "192.168.1.1",
    architecture           = "x86_64",
    cores                  = 6,
    host_type              = "x86-64-v2-AES",
    memory                 = 8192,
    keyboard_layout        = "en-us",
    vga_memory             = 16,
    vga_type               = "virtio",
    network_device_bridge  = "vmbr0",
    network_device_enabled = true,
    operating_system_type  = "l26",
    reboot                 = false,
    disk_in_gb             = 75
  }
  vm3 = {
    vm_name                = "vm3",
    vm_id                  = 403,
    proxmox_node_name      = "pve3",
    vm_description         = "Rocky Linux 9 VM",
    ipv4_address           = "192.168.1.213/24",
    ipv4_gateway           = "192.168.1.1",
    architecture           = "x86_64",
    cores                  = 6,
    host_type              = "x86-64-v2-AES",
    memory                 = 8192,
    keyboard_layout        = "en-us",
    vga_memory             = 16,
    vga_type               = "virtio",
    network_device_bridge  = "vmbr0",
    network_device_enabled = true,
    operating_system_type  = "l26",
    reboot                 = false,
    disk_in_gb             = 75
  }
  vm4 = {
    vm_name                = "vm4",
    vm_id                  = 404,
    proxmox_node_name      = "pve4",
    vm_description         = "Rocky Linux 9 VM",
    ipv4_address           = "192.168.1.214/24",
    ipv4_gateway           = "192.168.1.1",
    architecture           = "x86_64",
    cores                  = 6,
    host_type              = "x86-64-v2-AES",
    memory                 = 8192,
    keyboard_layout        = "en-us",
    vga_memory             = 16,
    vga_type               = "virtio",
    network_device_bridge  = "vmbr0",
    network_device_enabled = true,
    operating_system_type  = "l26",
    reboot                 = false,
    disk_in_gb             = 75
  }
  vm5 = {
    vm_name                = "vm5",
    vm_id                  = 405,
    proxmox_node_name      = "pve5",
    vm_description         = "Rocky Linux 9 VM",
    ipv4_address           = "192.168.1.215/24",
    ipv4_gateway           = "192.168.1.1",
    architecture           = "x86_64",
    cores                  = 6,
    host_type              = "x86-64-v2-AES",
    memory                 = 8192,
    keyboard_layout        = "en-us",
    vga_memory             = 16,
    vga_type               = "virtio",
    network_device_bridge  = "vmbr0",
    network_device_enabled = true,
    operating_system_type  = "l26",
    reboot                 = false,
    disk_in_gb             = 75
  }
  vm6 = {
    vm_name                = "vm6",
    vm_id                  = 406,
    proxmox_node_name      = "pve6",
    vm_description         = "Rocky Linux 9 VM",
    ipv4_address           = "192.168.1.216/24",
    ipv4_gateway           = "192.168.1.1",
    architecture           = "x86_64",
    cores                  = 6,
    host_type              = "x86-64-v2-AES",
    memory                 = 8192,
    keyboard_layout        = "en-us",
    vga_memory             = 16,
    vga_type               = "virtio",
    network_device_bridge  = "vmbr0",
    network_device_enabled = true,
    operating_system_type  = "l26",
    reboot                 = false,
    disk_in_gb             = 75
  }
}
#
