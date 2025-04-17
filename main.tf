resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  # checkov best practices
  public_network_access_enabled   = false
  shared_access_key_enabled       = true # false is the best practices, but then while provisioning resource there is an error: 403 Key based authentication is not permitted on this storage account
  allow_nested_items_to_be_public = false

  min_tls_version = "TLS1_2"

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  sas_policy {
    expiration_period = "00.01:00:00"
  }

  tags = var.tags
}
