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
  sensitive   = true # Mark as sensitive for security best practice
}

# You can remove the old 'location' variable as we will define regions directly in the provider blocks.
# If you plan to use 'location' for other resources or a more generic setup, you might consider changing it to a map or list.
