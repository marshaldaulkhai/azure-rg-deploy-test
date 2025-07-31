# 1. Resource Group (comment this block if not required)
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}

# 2. App Service Plan
resource "azurerm_service_plan" "app_service_plan" {
  name                = local.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = var.app_service_plan_os_type
  sku_name            = var.app_service_plan_sku_name
  tags                = var.tags
}

# 3. Conditional: Linux Web App
resource "azurerm_linux_web_app" "linux_webapp" {
  count               = var.app_service_plan_os_type == "Linux" ? 1 : 0
  name                = local.web_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id
  https_only          = true
  app_settings        = var.app_settings
  tags                = var.tags

  identity {
    type = "SystemAssigned"
  }

  site_config {
  always_on = true
  
  # Health check requires both path and eviction time
  health_check_path               = "/api/health"
  health_check_eviction_time_in_min = 5   # or any suitable integer value like 5 or 10

  ftps_state             = "FtpsOnly"
  minimum_tls_version    = "1.2"
  worker_count           = 1

  application_stack {
    node_version = replace(var.linux_web_app_runtime_stack, "NODE|", "")
  }
}

}

# 4. Conditional: Windows Web App
resource "azurerm_windows_web_app" "windows_webapp" {
  count               = var.app_service_plan_os_type == "Windows" ? 1 : 0
  name                = local.web_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id
  https_only          = true
  app_settings        = var.app_settings
  tags                = var.tags

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = true
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = var.windows_web_app_dotnet_version
    }
    health_check_path        = "/api/health"
    ftps_state               = "FtpsOnly"
    minimum_tls_version      = "1.2"
    worker_count             = 1

    # Add/override other required config here
  }
}

# 5. (Optional, but at top for priority) Private Endpoint
resource "azurerm_private_endpoint" "webapp_pe" {
  count                 = var.enable_private_endpoint ? 1 : 0
  name                  = "${local.web_app_name}-pe"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  subnet_id             = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${local.web_app_name}-psc"
    private_connection_resource_id  = (
      var.app_service_plan_os_type == "Linux" ?
      azurerm_linux_web_app.linux_webapp[0].id :
      azurerm_windows_web_app.windows_webapp[0].id
    )
    subresource_names   = ["sites"]
    is_manual_connection = false
  }

  tags = var.tags
}

# 6. (Optional) Role Assignment for Private Endpoint
resource "azurerm_role_assignment" "pe_role_assignment" {
  count              = var.enable_private_endpoint ? 1 : 0
  scope              = var.private_endpoint_subnet_id
  principal_id       = (
    var.app_service_plan_os_type == "Linux" ?
    azurerm_linux_web_app.linux_webapp[0].identity[0].principal_id :
    azurerm_windows_web_app.windows_webapp[0].identity[0].principal_id
  )
  role_definition_name = "Network Contributor"
}

# ---- THE FOLLOWING RESOURCES CAN BE COMMENTED OUT IF NOT NEEDED -------------
# 7. (Optional) Monitoring: Diagnostic Settings
resource "azurerm_monitor_diagnostic_setting" "webapp_diag" {
  count                    = var.enable_monitoring && length(var.log_analytics_workspace_id) > 0 ? 1 : 0
  name                     = "${local.web_app_name}-diag"
  target_resource_id       = (
    var.app_service_plan_os_type == "Linux" ? 
    azurerm_linux_web_app.linux_webapp[0].id : 
    azurerm_windows_web_app.windows_webapp[0].id
  )
  log_analytics_workspace_id = var.log_analytics_workspace_id
  depends_on = [
    azurerm_linux_web_app.linux_webapp,
    azurerm_windows_web_app.windows_webapp
  ]
  enabled_log {
    category = "AuditEvent"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

# 8. (Optional) Source Control Integration
resource "azurerm_app_service_source_control" "sourcecontrol" {
  count                  = length(var.repository_url) > 0 ? 1 : 0
  app_id                 = (
    var.app_service_plan_os_type == "Linux" ?
    azurerm_linux_web_app.linux_webapp[0].id :
    azurerm_windows_web_app.windows_webapp[0].id
  )
  repo_url               = var.repository_url
  branch                 = var.repository_branch
  use_manual_integration = true
}
