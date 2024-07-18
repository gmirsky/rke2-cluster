terraform {
  required_version = ">= 0.14"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc2"
    }
  }
}

provider "proxmox" {
  pm_tls_insecure     = true
  pm_api_url          = "https://192.168.1.201:8006/api2/json"
  pm_api_token_secret = "cc2e72b9-d176-4fe7-8a72-80bdd89c7adc"
  pm_api_token_id     = "root@pam!terraform"
}
#cc2e72b9-d176-4fe7-8a72-80bdd89c7adc