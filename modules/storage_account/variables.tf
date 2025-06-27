variable "storage_account_name" {
  description = "Name of the storage account (must be globally unique)"
  type        = string
}

variable "container_name" {
  description = "Name of the blob container"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group to create the storage account in"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type"
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
