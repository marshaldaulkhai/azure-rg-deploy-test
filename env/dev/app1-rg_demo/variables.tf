# env/dev/app1-rg_demo/variables.tf

variable "resource_group_name_eastus" {
  description = "Name for the East US Resource Group."
  type        = string
}

variable "resource_group_name_westus" {
  description = "Name for the West US Resource Group."
  type        = string
}

variable "subscription_id" {
  description = "The Azure Subscription ID to deploy resources into."
  type        = string
  sensitive   = true
}