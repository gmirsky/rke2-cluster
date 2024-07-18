resource "proxmox_vm_qemu" "cloudinit-k3s-master" {
  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = "pve${count.index + 1}"
  desc        = "Ubuntu 24 LTS from cloud-init template"
  count       = 6
  onboot      = true

  # The template name to clone this vm from
  clone = "ubuntu24lts-1"

  # Activate QEMU agent for this VM
  agent = 0

  os_type = "cloud-init"
  cores   = 2
  sockets = 2
  numa    = true
  vcpus   = 0
  cpu     = "host"
  memory  = 4096
  name    = "rke2-node-${count.index + 1}"

  #cloudinit_cdrom_storage = "cephpool1"
  scsihw   = "virtio-scsi-single"
  bootdisk = "scsi0"

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "cephpool1"
          size    = 100
        }
      }
    }
  }

  # Setup the ip address using cloud-init.
  # Keep in mind to use the CIDR notation for the ip.
  ipconfig0    = "ip=192.168.1.13${count.index + 1}/24,gw=192.168.1.1"
  #ciuser       = "gmirsky"
  #cipassword   = "Test1234!"
  #nameserver   = "192.168.1.1"
  #searchdomain = "fios-router.home"
#   sshkeys      = <<EOF
# ssh-rsa ***************************************************
# EOF
}
#