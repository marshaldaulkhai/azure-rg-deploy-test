locals {
  env = lower(var.environment)
  os = lower(var.app_service_plan_os_type)
  locations = {
    centralus = "cu"
    eastus2   = "e2"
  }
  web_app_env = {
    dev  = "dev"
    test = "tst"
    prod = "prd"
    sandbox = "sbx"
    base    = "base"
  }
  short_location = local.locations[var.location]
  web_app_name   = "dte-app-${local.short_location}-${local.web_app_env[local.env]}-${lower(var.application_name)}"
  app_service_plan_name   = "asp-${local.short_location}-${local.web_app_env[local.env]}-${lower(var.application_name)}${lower.os}"
}
