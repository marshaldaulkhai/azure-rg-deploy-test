# variables.tf

variable "resource_group_name" {
  description = "The name of the resource group to create"
  type        = string
}

variable "location" {
  description = "The Azure location for the resource group"
  type        = string
}
