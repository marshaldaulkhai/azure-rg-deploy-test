variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure location"
  type        = string
  default     = "East US" # optional default value
}

variable "web_app_name" {
  description = "The name for the web app"
  type        = string
}

variable "main_client_id" {
  description = "The client ID for the main service principal"
  type        = string
}

variable "main_client_secret" {
  description = "The client secret for the main service principal"
  type        = string
  sensitive   = true
}

variable "main_tenant_id" {
  description = "The tenant ID for the main Azure tenant"
  type        = string
}


