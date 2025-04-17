# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
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

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting
resource "azurerm_monitor_diagnostic_setting" "storage_account" {
  name               = "${var.resource_group_name}-monitor-st"
  target_resource_id = azurerm_storage_account.this.id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  # enabled_log {
  #   category_group = "AllLogs"
  # }

  # metric {
  #   category = "AllMetrics"
  # }

  metric {
    category = "Capacity"
    enabled  = true
  }

  metric {
    category = "Transaction"
    enabled  = true
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config
data "azurerm_client_config" "current" {}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
resource "azurerm_key_vault" "this" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.key_vault_sku_name

  # checkov best practices
  purge_protection_enabled      = false # true is the best practices, but not allowed in my Azure policy
  public_network_access_enabled = true  # # false is the best practices, but then while provisioning resource there is an error: Public network access is disabled and request is not from a trusted service nor via an approved private link

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = [var.allowed_ip]
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy
resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy"]
  secret_permissions = ["Get"]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key
resource "azurerm_key_vault_key" "this" {
  name         = "${var.resource_group_name}-key"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA" # "RSA-HSM" Hardware key operation not allowed on standard vault
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  expiration_date = formatdate("YYYY-MM-DD'T'hh:mm:ssZ", timeadd(timestamp(), "8760h")) # 1 year

  lifecycle {
    ignore_changes = [
      expiration_date
    ]
  }

  depends_on = [
    azurerm_key_vault_access_policy.this
  ]
}

# cannot be used because Key Vault must be configured for both Purge Protection and Soft Delete (it's forbidden in my Azure policy)
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key
# resource "azurerm_storage_account_customer_managed_key" "this" {
#   storage_account_id = azurerm_storage_account.this.id
#   key_vault_id       = azurerm_key_vault.this.id
#   key_name           = azurerm_key_vault_key.this.name
# }

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
resource "azurerm_log_analytics_workspace" "this" {
  name                = "${var.resource_group_name}-logs"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting
resource "azurerm_monitor_diagnostic_setting" "key_vault" {
  name               = "${var.resource_group_name}-monitor-kv"
  target_resource_id = azurerm_key_vault.this.id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  # enabled_log {
  #   category_group = "AllLogs"
  # }

  metric {
    category = "AllMetrics"
  }
}
