variable "rg1" {
  description = "The name of the resource group where SP,STA,KVT resides "
}

variable "location" {
  description = "Location"
}

variable "vnet" {
  description = "The name of the virtual Network where resources needs to be created"

}

variable "vnetrg" {
  description = "The name of the Resource group where vnet resides"
}

variable "subnet" {
  description = "The name of the subnet in which the resources will be created"
}

variable "keyvault" {
  description = "The name of the Dev Subscription Key Vault"
}

variable "wgadminuser" {
  description = "The name of the Dev Subscription Key"
}

variable "wgadminpwd" {
  description = "The name of the Dev Subscription Key for vm "
  default     = "VMAdminPass"
}

// variable "storageacckey" {
//   description = "The name of the Storage Account Key"
//   default     = "StorageAccountkey1"
// }

variable "hostname" {
  description = "The name of the virtual machine will be created"
}

variable "diskcreate" {
  description = "If set to l additonal disk will be created"
}

variable "disksizegb" {
  description = "The size of the additonal disk will be created"
}

variable "VmSize" {
  description = "size of vm"

}

variable "ipType" {
  description = "The type of the IP allocation"
  default     = "Dynamic"
}

variable "oscaching" {
  description = "Caching type of OS disk"
  default     = "ReadWrite"
}

variable "diskcaching" {
  description = "Caching type of OS disk"
  default     = "ReadOnly"
}

variable "OS_storageaccType" {
  description = "Storage Account Type"
}

variable "datadisk_storageaccType" {
  description = "Storage Account Type"
}

variable "identity" {
  description = "Identity Type"
  default     = "SystemAssigned"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}


