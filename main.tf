# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "this" {
  name                     = "${replace(var.prefix, "-", "")}st"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  public_network_access_enabled   = false
  shared_access_key_enabled       = true # false is the best practices, but then while provisioning resource there is an error: 403 Key based authentication is not permitted on this storage account
  allow_nested_items_to_be_public = false

  min_tls_version = "TLS1_2"

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = [var.allowed_ip]
  }

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

module "monitor" {
  source = "./modules/monitor"

  prefix = var.prefix

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting
resource "azurerm_monitor_diagnostic_setting" "storage_account" {
  name               = "${var.prefix}-monitor-st"
  target_resource_id = azurerm_storage_account.this.id

  log_analytics_workspace_id = module.monitor.log_analytics_workspace_id

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

module "key_vault" {
  source = "./modules/key-vault"

  prefix = var.prefix

  allowed_ip                 = var.allowed_ip
  log_analytics_workspace_id = module.monitor.log_analytics_workspace_id

  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key
resource "azurerm_key_vault_key" "this" {
  name         = "${var.prefix}-key"
  key_vault_id = module.key_vault.key_vault_id
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
    module.key_vault
  ]
}

# cannot be used because Key Vault must be configured for both Purge Protection and Soft Delete (it's forbidden in my Azure policy)
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key
# resource "azurerm_storage_account_customer_managed_key" "this" {
#   storage_account_id = azurerm_storage_account.this.id
#   key_vault_id       = azurerm_key_vault.this.id
#   key_name           = azurerm_key_vault_key.this.name
# }
