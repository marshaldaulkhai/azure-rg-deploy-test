# env/dev/app1-rg_demo/terraform.tfvars

resource_group_name_eastus = "my-rg-east-sp-demo"
resource_group_name_westus = "my-rg-west-sp-demo"
subscription_id            = "YOUR_AZURE_SUBSCRIPTION_ID_HERE" # Your actual Azure Subscription ID

# --- Credentials for the main (default) Service Principal ---
main_client_id            = "YOUR_MAIN_SERVICE_PRINCIPAL_CLIENT_ID"
main_client_secret        = "YOUR_MAIN_SERVICE_PRINCIPAL_CLIENT_SECRET"
main_tenant_id            = "YOUR_MAIN_AZURE_TENANT_ID"

# --- Credentials for the aliased (audit) Service Principal ---
audit_client_id            = "YOUR_AUDIT_SERVICE_PRINCIPAL_CLIENT_ID"
audit_client_secret        = "YOUR_AUDIT_SERVICE_PRINCIPAL_CLIENT_SECRET"
audit_tenant_id            = "YOUR_AUDIT_AZURE_TENANT_ID"