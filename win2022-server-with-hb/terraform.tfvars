# Variables
vm_name         = "mss-hb-001"
vm_rg_name      = "mss-rg-servers-hb"
sec_rg_name     = "mss-rg-sec"
keyvault_name   = "mss-kv-prod01mnui"
location        = "westeurope"
vnetrg          = "mss-rg-network"
vnetname        = "mss-vn-prod"
subname         = "mss-sn-prod-dc"
vm_private_ip   = "10.13.1.101"
vm_size         = "Standard_D2as_v5"
vm_avzone       = "3"                   # 1, 2, 3 - West Europe
vm_bootdiag     = "msssadiagcool01mnui"
bootdiag_rg_name= "mss-rg-infra"
vm_username     = "azlocadmin"
vm_password     = ""
tag_environment = "prod"
tag_workload    = "server hb"
offer           = "WindowsServer"
publisher       = "MicrosoftWindowsServer"
sku             = "2022-datacenter-azure-edition"
# Premium_LRS
vm_storage      = "Premium_LRS"
vm_timezone     = "W. Europe Standard Time"
vm_url          = "https://github.com/MarkSwinkels/Terraform/blob/main/Scripts/post_install.ps1"
# Data Disk
vm_data_disk    = "32"
