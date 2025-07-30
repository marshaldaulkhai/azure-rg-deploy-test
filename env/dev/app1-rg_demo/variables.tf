variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-angular-webapp-demo"
}

variable "location" {
  description = "The Azure location/region"
  type        = string
  default     = "West Europe"
}

variable "web_app_name" {
  description = "The name for the web app"
  type        = string
  default     = "angular-webapp-demo-12345"
}

variable "app_service_plan_name" {
  description = "The name for the App Service Plan"
  type        = string
  default     = "asp-angular-demo"
}

variable "app_service_plan_os_type" {
  description = "The OS type of the App Service Plan (Linux or Windows)"
  type        = string
  default     = "Windows"
}

variable "app_service_plan_sku_name" {
  description = "SKU name for the App Service Plan (e.g. S1, B1, P1v2)"
  type        = string
  default     = "B1"   # Basic tier is often suitable for Angular apps
}

variable "web_app_runtime_stack" {
  description = "Specifies the runtime stack for the web app (LinuxFxVersion for Linux, or dotnet_version for Windows)"
  type        = string
  default     = "NODE|18-lts"  # Node.js 18 LTS runtime for Angular apps
}

variable "app_settings" {
  description = "App Settings (environment variables) for the web app"
  type        = map(string)
  default     = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "18"
  }
}

variable "repository_url" {
  description = "GitHub repository URL for source control"
  type        = string
  default     = ""
}

variable "repository_branch" {
  description = "Branch of the repository to deploy"
  type        = string
  default     = "main"
}

variable "enable_private_endpoint" {
  description = "Create private endpoint for the Web App"
  type        = bool
  default     = true
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for the private endpoint"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    "Environment" = "Dev"
    "Project"     = "AngularApp"
  }
}

variable "enable_monitoring" {
  description = "Enable Azure Monitor Diagnostic Settings for web app"
  type        = bool
  default     = false
}

variable "log_analytics_workspace_id" {
  description = "Resource ID of Log Analytics Workspace for diagnostics"
  type        = string
  default     = ""
}
variable "main_client_id" {
  description = "The client ID for the main Azure Service Principal"
  type        = string
  default     =  "3e55028d-9cce-462e-bd5b-85d37adf811b"
}

variable "main_client_secret" {
  description = "The client secret for the main Azure Service Principal"
  type        = string
  default     = "e3Z8Q~WDx5h2R14SOiPp~Sxn4TdaANzOTlqe3aA-"
}

variable "main_tenant_id" {
  description = "The tenant ID for the Azure Active Directory tenant"
  type        = string
  default     = "985fb370-1790-4d59-adea-4bfd1e00486d"
}
