# main.tf
#
# This file defines the core Azure resources for the angular-webapp module.
# It includes the App Service Plan, App Service, Private Endpoint,
# User-Assigned Managed Identity, and Application Insights.

# Conditionally create a Resource Group if specified by the user
resource "azurerm_resource_group" "webapp_rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

# Conditionally create an Azure App Service Plan
resource "azurerm_service_plan" "webapp_plan" { # Changed resource type here
  count               = var.create_app_service_plan ? 1 : 0
  name                = local.app_service_plan_final_name
  location            = var.location
  resource_group_name = var.create_resource_group ? azurerm_resource_group.webapp_rg[0].name : var.resource_group_name
  os_type             = var.app_service_plan_os_type # Changed 'kind' to 'os_type'
  sku_name            = "${var.app_service_plan_sku_tier}_${var.app_service_plan_sku_size}" # Changed to sku_name format
  tags                = local.common_tags
}

# Azure App Service for the Angular Web App
resource "azurerm_app_service" "angular_webapp" {
  name                = local.app_service_final_name
  location            = var.location
  resource_group_name = var.create_resource_group ? azurerm_resource_group.webapp_rg[0].name : var.resource_group_name
  app_service_plan_id = var.create_app_service_plan ? azurerm_service_plan.webapp_plan[0].id : var.existing_app_service_plan_id
  
  # Site configuration for the App Service
  site_config {
    # Directly pass the map of site_config settings.
    # Terraform will map keys in var.site_config_settings to arguments in site_config.
    # Ensure keys in var.site_config_settings match valid site_config arguments.
    # Common ones are always_on, http20_enabled, etc.
    # For a static Angular app, you might also want to set default_documents,
    # or handle the WEBSITE_RUN_FROM_PACKAGE via app_settings.
    # If the App Service is just serving static files, many site_config options
    # related to specific runtimes (like dotnet_version) might not be needed.
    #
    # Example: If var.site_config_settings is { http20_enabled = true, always_on = true }
    # This will expand to:
    # http20_enabled = true
    # always_on = true
    for_each = var.site_config_settings # Use for_each to iterate over the map
    labels   = [each.key] # Use the key as a label for the setting
    content {
      # This is a bit tricky with dynamic blocks for site_config.
      # The best way is to set specific known arguments.
      # Let's simplify and assume direct mapping or explicitly list common ones.
      #
      # A more robust way for site_config is to list common arguments
      # and use lookup to get their values from var.site_config_settings.
      # For example:
      # http20_enabled = lookup(var.site_config_settings, "http20_enabled", null)
      # always_on      = lookup(var.site_config_settings, "always_on", null)
      #
      # However, if you want full flexibility, you'd define a map in variables.tf
      # like:
      # variable "site_config" {
      #   type = object({
      #     always_on = bool
      #     http20_enabled = bool
      #     # ... other properties
      #   })
      #   default = {
      #     always_on = true
      #     http20_enabled = true
      #   }
      # }
      # And then use:
      # always_on = var.site_config.always_on
      # http20_enabled = var.site_config.http20_enabled
      #
      # Let's go with the direct mapping, assuming the keys in var.site_config_settings
      # are actual site_config arguments.

      # This approach is generally for a known set of arguments.
      # If you want to dynamically set *any* setting, you'd need to use a
      # more complex local or a different resource type.
      # For now, let's assume common ones.
      # To fix the "Unsupported block type setting" error, you cannot use dynamic "setting"
      # inside site_config. You must set specific arguments.
      #
      # The simplest fix to proceed is to explicitly list the common settings
      # and use `lookup` with a default of `null` so they are only set if provided.

      always_on      = lookup(var.site_config_settings, "always_on", null)
      http20_enabled = lookup(var.site_config_settings, "http20_enabled", null)
      # Add other site_config arguments here as needed, using lookup
      # e.g., default_documents = lookup(var.site_config_settings, "default_documents", ["index.html"])
      # If you want to serve Angular files, you typically don't need to specify
      # a specific runtime version here, as the App Service will just serve the files.
  }
}

  # Application settings for the App Service
  app_settings = var.app_settings # Directly use the map passed by the caller

  # Managed Identity for the App Service
  identity {
    type = "SystemAssigned" # System-assigned identity is often simpler for App Services
  }

  tags = local.common_tags
}

# Azure Application Insights for monitoring (optional)
resource "azurerm_application_insights" "app_insights" {
  count                = var.enable_application_insights ? 1 : 0
  name                 = "${var.application_name}-appinsights-${var.environment}"
  location             = var.location
  resource_group_name  = var.create_resource_group ? azurerm_resource_group.webapp_rg[0].name : var.resource_group_name
  application_type     = "Web" # Appropriate for web applications
  daily_data_cap_in_gb = var.app_insights_daily_data_cap_in_gb
  retention_in_days    = var.app_insights_retention_in_days
  tags                 = local.common_tags
}

# Private Endpoint for the App Service
resource "azurerm_private_endpoint" "angular_app_service_pe" {
  count             = var.create_private_endpoint ? 1 : 0
  name              = "${var.application_name}-pe-appservice-${var.environment}"
  resource_group_name = var.create_resource_group ? azurerm_resource_group.webapp_rg[0].name : var.resource_group_name
  location          = var.location
  subnet_id         = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.application_name}-psc-appservice-${var.environment}"
    private_connection_resource_id = azurerm_app_service.angular_webapp.id
    is_manual_connection           = false
    subresource_names              = ["sites"] # For App Services
  }

  # This is crucial for DNS resolution over Private Link
  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zone_ids) > 0 ? [1] : []
    content {
      name                 = "default"
      private_dns_zone_ids = var.private_dns_zone_ids # Expecting privatelink.azurewebsites.net for App Service
    }
  }

  tags = local.common_tags
}

# Note: Azure Front Door or Application Gateway would typically be provisioned
# by a higher-level module (like the three-layered-serverless-app-pattern)
# and would reference the 'default_host_name' output of this module as its origin.
