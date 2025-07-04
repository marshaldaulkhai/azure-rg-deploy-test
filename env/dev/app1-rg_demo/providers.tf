# env/dev/app1-rg_demo/providers.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0.0"
}

# Configure the Default AzureRM Provider (using your main Service Principal credentials)
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.main_client_id
  client_secret   = var.main_client_secret
  tenant_id       = var.main_tenant_id
}

# Configure an Aliased AzureRM Provider (for audit/restricted access, using a different Service Principal)
provider "azurerm" {
  alias           = "audit_access" # This is our alias for the audit SP
  features {}
  subscription_id = var.subscription_id # Still targeting the same subscription
  client_id       = var.audit_client_id
  client_secret   = var.audit_client_secret
  tenant_id       = var.audit_tenant_id
}