#resource "azurerm_resource_group" "vm-rg" {
data "azurerm_resource_group" "vm-rg" {
  name = var.vm_rg_name
}

#Use existing network resources
data "azurerm_resource_group" "vnet-rg" {
  name = var.vnetrg
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  resource_group_name = data.azurerm_resource_group.vnet-rg.name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subname
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.vnet-rg.name
}

data "azurerm_storage_account" "vm_bootdiag" {
  name                 = var.vm_bootdiag
  resource_group_name  = var.bootdiag_rg_name
}

// Get Keyvault Data
data "azurerm_resource_group" "rg_keyvault" {
  name                = "${var.sec_rg_name}"
}
data "azurerm_key_vault" "keyvault" {
  name                = "${var.keyvault_name}"
  resource_group_name = "${data.azurerm_resource_group.rg_keyvault.name}"
}
data "azurerm_key_vault_secret" "vmpassword" {
  name      = "vmpassword"
  key_vault_id = "${data.azurerm_key_vault.keyvault.id}"
}

resource "azurerm_network_interface" "netinterface" {
  name                            = "${var.vm_name}-nic"
  location                        = var.location
  resource_group_name             = var.vm_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.vm_private_ip    
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  admin_username                  = var.vm_username
  admin_password                  = "${data.azurerm_key_vault_secret.vmpassword.value}"
  # var.vm_password
  location                        = var.location
  name                            = var.vm_name
  network_interface_ids           = [azurerm_network_interface.netinterface.id]
  resource_group_name             = var.vm_rg_name
  license_type                    = "Windows_Server"
  secure_boot_enabled             = true
  provision_vm_agent              = true
  size                            = var.vm_size
  tags = {
    Environment                   = var.tag_environment
    Workload                      = var.tag_workload
  }
  timezone                        = var.vm_timezone
  vtpm_enabled                    = true
  zone                            = var.vm_avzone
  #priority                       = "Spot"
  #eviction_policy               	= "Deallocate"
  os_disk {
    name                          = "${var.vm_name}-osdisk"
    caching                       = "ReadWrite"
    storage_account_type          = var.vm_storage
  }
  source_image_reference {
    offer                         = var.offer
    publisher                     = var.publisher
    sku                           = var.sku
    version                       = "latest"
  }
  boot_diagnostics {
    storage_account_uri           = data.azurerm_storage_account.vm_bootdiag.primary_blob_endpoint
  }
}

resource "azurerm_managed_disk" "vm_data_disk" {
  name                            = "${var.vm_name}-datadisk01"
  location                        = var.location
  resource_group_name             = var.vm_rg_name
  storage_account_type            = var.vm_storage
  create_option                   = "Empty"
  disk_size_gb                    = var.vm_data_disk
  zone                            = var.vm_avzone
  tags = {
    omgeving                      = var.tag_environment
    type                          = var.tag_workload
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "vm_data_disk" {
  managed_disk_id                       = azurerm_managed_disk.vm_data_disk.id
  virtual_machine_id                    = azurerm_windows_virtual_machine.vm.id
  lun                                   = "1"
  caching                               = "None"
}