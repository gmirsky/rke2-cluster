resource "local_file" "pssh_hosts" {
  content = templatefile(
    "${path.cwd}/templates/pssh_hosts.tftpl",
    {
      ip4_addresses = local.server_ips
    }
  )
  filename        = "pssh_hosts"
  file_permission = "0777"
}
#
