variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}
/*
variable "storage_account_name" {
  description = "Globally unique name for the storage account"
  type        = string
}

variable "container_name" {
  description = "Name of the blob container"
  type        = string
  default     = "tfstate"
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type for the storage account"
  type        = string
  default     = "LRS"
}
/*
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
*/
