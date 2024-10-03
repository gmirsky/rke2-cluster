# #
# # NOTE: Snippets is not enabled by default in Proxmox. You must enable them by
# # going to datacenter -> storage and adding snippets to the local data store.
# #
# resource "proxmox_virtual_environment_file" "hook_script" {
#   count        = local.server_count
#   content_type = "snippets"
#   datastore_id = "local"
#   node_name    = var.vm[(keys(var.vm))[count.index]].proxmox_node_name
#   # Hook scripts must be executable, otherwise the Proxmox VE API will reject the configuration for the VM/CT.
#   file_mode = "0700"
#   overwrite = true
#   source_raw {
#     data      = <<-EOF
#       #!/usr/bin/bash
#       echo "Running hook script"
#       sudo dnf install python3.11 iptables -y
#       EOF
#     file_name = "prepare-hook.sh"
#   }
# }
# #
