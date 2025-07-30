variable "app_service_plan_sku" {
  description = "The SKU name for the App Service Plan"
  type        = string
  default     = "S1"
}

variable "app_service_plan_sku_tier" {
  description = "The pricing tier of the app service plan"
  type        = string
  default     = "Standard"
}

variable "app_service_plan_sku_size" {
  description = "The SKU size of the app service plan"
  type        = string
  default     = "S1"
}
