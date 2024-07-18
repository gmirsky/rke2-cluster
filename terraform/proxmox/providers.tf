provider "proxmox" {
  pm_tls_insecure     = true
  pm_api_url          = "https://192.168.1.201:8006/api2/json"
  pm_api_token_secret = "************************************"
  pm_api_token_id     = "root@pam!terraform"
}
#