# env/dev/app1-rg_demo/terraform.tfvars

resource_group_name_eastus = "my-rg-east-sp-demo"
resource_group_name_westus = "my-rg-west-sp-demo"
subscription_id            = "6d41859f-600b-4bdf-9b5d-084a0582cb54" # Your actual Azure Subscription ID

# --- Credentials for the main (default) Service Principal ---
main_client_id            = ""
main_client_secret        = ""
main_tenant_id            = ""

# --- Credentials for the aliased (audit) Service Principal ---
audit_client_id            = ""
audit_client_secret        = ""
audit_tenant_id            = ""
