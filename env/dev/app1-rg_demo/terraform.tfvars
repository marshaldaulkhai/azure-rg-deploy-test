# env/dev/app1-rg_demo/terraform.tfvars

resource_group_name_eastus = "my-rg-east-sp-demo"
resource_group_name_westus = "my-rg-west-sp-demo"
subscription_id            = "6d41859f-600b-4bdf-9b5d-084a0582cb54" # Your actual Azure Subscription ID

# --- Credentials for the main (default) Service Principal ---
main_client_id            = "3e55028d-9cce-462e-bd5b-85d37adf811b"
main_client_secret        = "e3Z8Q~WDx5h2R14SOiPp~Sxn4TdaANzOTlqe3aA-"
main_tenant_id            = "985fb370-1790-4d59-adea-4bfd1e00486d"

# --- Credentials for the aliased (audit) Service Principal ---
audit_client_id            = "Y81cbd665-5a65-4e35-8d33-c0e1afda01c9"
audit_client_secret        = "sKm8Q~9cGoPGvPW6c6Y4Sg.FbcE3FLy-1qJOAcqw"
audit_tenant_id            = "Y985fb370-1790-4d59-adea-4bfd1e00486d"
