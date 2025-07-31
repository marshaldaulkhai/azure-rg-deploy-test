location            = "eastus2"
resource_group_name = "TestRG"
environment          = "Dev"
tags              ={
    Environment         = "abc"
    Portfolio           = "abc"
    Application         = "abc"
    BillTo              = "abc"
    ContactEmail        = "abc"
    BusinessCriticality = "abc"
    DataClassification  = "abc"
}

# --- Credentials for the main (default) Service Principal ---
main_client_id            = "cd436b46-02e0-4438-adff-84d70c6baae4"
main_client_secret        = "Lv68Q~RK_ZnEnfbN8Jd6y3qzcy4SXZqIgHHdgacW"
main_tenant_id            = "7998c5af-239c-4658-8550-006eabdfeadd"

enable_private_endpoint = true
private_endpoint_subnet_id = "/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>/subnets/<subnet-name>"

