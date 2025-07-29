# --- Credentials for the main (default) Service Principal 
resource_group_name = "example-app-rg"
location            = "East US"
app_service_plan_id = "/subscriptions/6d41859f-600b-4bdf-9b5d-084a0582cb54/resourceGroups/example-app-rg/providers/Microsoft.Web/serverfarms/example-appservice-plan"
web_app_name        = "example-webapp-12345"


variable "location" {
  description = "The Azure location to deploy resources"
  type        = string
  default     = "East US"   # optional; remove default if you want it mandatory
}

variable "web_app_name" {
  description = "The name of the web app (must be globally unique)"
  type        = string
}

variable "audit_tenant_id" {
  description = "Tenant ID for audit purposes"
  type        = string
}

variable "main_client_id" {
  description = "Client ID for main app"
  type        = string
}

variable "main_client_secret" {
  description = "Client secret for main app"
  type        = string
  sensitive   = true
}

variable "main_tenant_id" {
  description = "Tenant ID for the main app"
  type        = string
}

variable "audit_client_id" {
  description = "Audit client ID"
  type        = string
}

variable "audit_client_secret" {
  description = "Audit client secret"
  type        = string
  sensitive   = true
}

