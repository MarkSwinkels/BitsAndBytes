variable "vnetrg" {
  type        = string
  description = "Resource Group existing VNET"
}

variable "subname" {
  type        = string
  description = "Existing Subnet"
}

variable "vnetname" {
  type        = string
  description = "Existing VNET name"
}

variable "location" {
  type        = string
  description = "Azure DC location"
}

variable "vm_rg_name" {
  type        = string
  description = "Resource Group for template VMs"
}

variable sec_rg_name {
  type        = string
  description = "Resource Group Security"
}

variable keyvault_name {
  type        = string
  description = "Keyvault name"
}

variable "vm_name" {
  type        = string
  description = "VM name"
}

variable "vm_username" {
  type        = string
  description = "(optional) describe your variable"
}

variable "vm_password" {
  type        = string
  description = "(optional) describe your variable"
  sensitive   = true
}

variable "vm_size" {
  type        = string
  description = "(optional) describe your variable"
}

variable "vm_storage" {
  type        = string
  description = "(optional) describe your variable"
}

variable "vm_private_ip" {
  type        = string
  description = "Private IP address"
}

variable "vm_avzone" {
  type        = string
  description = "Availability Zone"
}

variable "vm_data_disk" {
  type        = string
  description = "Size of data disk"
}

variable "vm_bootdiag" {
  type        = string
  description = "Boot diagnostics name"
}

variable "bootdiag_rg_name" {
  type        = string
  description = "Resource group of diag storage account"
}

variable "tag_environment" {
  type        = string
  description = "Tag environment"
}

variable "tag_workload" {
  type        = string
  description = "Tag workload"
}

variable "offer" {
  type        = string
  description = "Windows offer"
}

variable "publisher" {
  type        = string
  description = "Publisher"
}

variable "sku" {
  type        = string
  description = "SKU"
}

variable "vm_timezone" {
  type        = string
  description = "time zone"
}

variable "vm_url" {
  type        = string
  description = "URL for the post installation script"
}