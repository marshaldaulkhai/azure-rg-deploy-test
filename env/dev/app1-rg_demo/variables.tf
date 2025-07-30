variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure location/region"
  type        = string
}

variable "web_app_name" {
  description = "The name for the web app"
  type        = string
}

variable "app_service_plan_name" {
  description = "The name for the App Service Plan"
  type        = string
}

variable "app_service_plan_os_type" {
  description = "The OS type of the App Service Plan (Linux or Windows)"
  type        = string
  default     = "Linux" # Change to "Windows" if needed
}

variable "app_service_plan_sku_name" {
  description = "SKU name for the App Service Plan (e.g. S1, B1, P1v2)"
  type        = string
  default     = "S1"
}

variable "web_app_runtime_stack" {
  description = "Specifies the runtime stack for the web app (LinuxFxVersion for Linux, or dotnet_version for Windows)"
  type        = string
  default     = "NODE|18-lts"  # Default Linux Node.js 18 LTS
}

variable "app_settings" {
  description = "App Settings (environment variables) for the web app"
  type        = map(string)
  default     = {}
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
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for the private endpoint"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
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
