resource "proxmox_virtual_environment_download_file" "this" {
  count        = local.server_count
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.vm[(keys(var.vm))[count.index]].proxmox_node_name
  url          = var.cloud_image_url
  file_name    = var.cloud_image_file_name
}
#
