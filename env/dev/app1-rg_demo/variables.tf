# env/dev/app1-rg_demo/variables.tf

variable "resource_group_name_eastus" {
  description = "Name for the East US Resource Group."
  type        = string
}

variable "resource_group_name_westus" {
  description = "Name for the West US Resource Group."
  type        = string
}

# This will be the single subscription ID used by both providers
variable "subscription_id" {
  description = "The Azure Subscription ID to deploy resources into."
  type        = string
  sensitive   = true
}

# --- Variables for the main (default) Service Principal ---
variable "main_client_id" {
  description = "Client ID for the main service principal."
  type        = string
  sensitive   = true
}

variable "main_client_secret" {
  description = "Client Secret for the main service principal."
  type        = string
  sensitive   = true
}

variable "main_tenant_id" {
  description = "Tenant ID for the main service principal."
  type        = string
  sensitive   = true
}

# --- Variables for the aliased (audit) Service Principal ---
variable "audit_client_id" {
  description = "Client ID for the audit service principal."
  type        = string
  sensitive   = true
}

variable "audit_client_secret" {
  description = "Client Secret for the audit service principal."
  type        = string
  sensitive   = true
}

variable "audit_tenant_id" {
  description = "Tenant ID for the audit service principal."
  type        = string
  sensitive   = true
}
