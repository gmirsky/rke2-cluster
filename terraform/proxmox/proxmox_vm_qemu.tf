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
# ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC68h9GRt61EV1ZOjHz1bc00RTmIPz0n21yuXghovICO0GiGGLt0sr0XB4KdzSv77+NFPwtngKp74XP1m8ebMDFyDbJtt9z+9K7vlkHB2Z1dusIM7qwWzB/ypxvPTHw6KN6shQ0uChh4KzTiy089KI2CxWa/g+b3CeS3xsW+A03Y6Q2tsPDHzEtBZJqNZf811lOCrCLXwZHIaa2HG6nCcgztkNMbVx8hLE5wHFzpP52ILqltiXWsYhjmz59sxHWQjl5eM52uYeMs+QOg9/RNRl8TkVb0TCD0rgE1vcOsr2Cq/cMbNVcIo/gTvnXAXT2HqZ+nczPzJ/feu3ziWdVpGK0HP+IlCb2UGFovsjArZltuZdba86bEaf6KsgSJsTbHXIJY+vYE7otr+2/hdztFTjX5HfkjRKTELDIj57E8eS5t9DLHAkHPKwODGvyLAnZ9HDSJ66L4JsFJ4Q7S45UGZqnGotEdtZ/UAgYnBO1LjDPeAe6AGsdj7yBqzpCbYoBwYIXoZ6B+bz9AEDC0jKDISbyiliTlJ4nEGCHi6QIJ0ON/7XIDCF6q888hM7QRqfoOVhC08VmettFirUENE3b1zCEQ53RukJ5sPqdTgcITyrQ90OqiYioxCnTi9KQ4jiiZBN612tf/P1DneoxnP7iilkTKyB1RmJ2G5NdGPDZEit4dQ== gregorymirsky@Gregorys-MBP.fios-router.home
# EOF
}
#