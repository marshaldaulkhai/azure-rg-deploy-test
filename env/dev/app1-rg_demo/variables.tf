variable "application_name" {
  type        = string
  description = "The logical name of the application"
  default     =  "sos-ui"
}
variable "product" {
  type        = string
  description = "The name of the product"
  default     =  "product1"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  validation {
    condition     = contains(["centralus", "eastus2"], var.location)
    error_message = "Location must be: centralus or eastus2"
  }
}

variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type = object({
    Environment         = string
    Portfolio           = string
    Application         = string
    BillTo              = string
    ContactEmail        = string
    BusinessCriticality = string
    DataClassification  = string
  })
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  validation {
    condition     = contains(["Sandbox", "Base", "Dev", "Test", "Prod"], var.environment)
    error_message = "Environment must be one of: Sandbox, Base, Dev, Test, Prod"
  }
}

# --- App Service Plan variables ---
variable "app_service_plan_name" {
  description = "App Service Plan name"
  type        = string
  default     = "asp-webapp"
}

variable "app_service_plan_os_type" {
  description = "OS: Linux or Windows"
  type        = string
  default     = "Linux"
}

variable "app_service_plan_sku_name" {
  description = "SKU (e.g. B1, S1, P1v2)"
  type        = string
  default     = "B1"
}

# --- Web App settings ---
variable "app_settings" {
  description = "App environment variables"
  type        = map(string)
  default = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "18"
  }
}

variable "linux_web_app_runtime_stack" {
  description = "Linux runtime stack (e.g. NODE|18-lts)"
  type        = string
  default     = "NODE|18-lts"
}

variable "windows_web_app_dotnet_version" {
  description = "Windows .NET version"
  type        = string
  default     = "v8.0"
}

# --- Private Endpoint ---
variable "enable_private_endpoint" {
  description = "Deploy Private Endpoint for WebApp"
  type        = bool
  default     = true
}
variable "private_endpoint_subnet_id" {
  description = "Subnet ID for Private Endpoint"
  type        = string
  default     = ""
}

# --- Monitoring ---
variable "enable_monitoring" {
  description = "Enable Azure Monitor Diagnostic Settings"
  type        = bool
  default     = false
}
variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID"
  type        = string
  default     = ""
}

# --- Source Control (Optional) ---
variable "repository_url" {
  description = "Source control repository URL"
  type        = string
  default     = ""
}
variable "repository_branch" {
  description = "Branch to deploy"
  type        = string
  default     = "main"
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
variable "enable_private_endpoint" {
  description = "Create private endpoint for the Web App"
  type        = bool
  default     = true
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for Private Endpoint"
  type        = string
}

variable "skip_dns_zone_for_pep" {
  description = "Skip private DNS zone configuration for private endpoint"
  type        = bool
  default     = false
}

variable "dns_zone_ids" {
  description = "Map of DNS zone IDs for different private endpoint subresources (e.g., 'sites')"
  type        = map(string)
  default     = {}
}
