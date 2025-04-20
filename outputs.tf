output "storage_account_details" {
  description = "Storage account details"
  value = {
    id   = azurerm_storage_account.this.id
    name = azurerm_storage_account.this.name
    endpoints = {
      blob  = azurerm_storage_account.this.primary_blob_endpoint
      queue = azurerm_storage_account.this.primary_queue_endpoint
      table = azurerm_storage_account.this.primary_table_endpoint
      file  = azurerm_storage_account.this.primary_file_endpoint
      dfs   = azurerm_storage_account.this.primary_dfs_endpoint
      web   = azurerm_storage_account.this.primary_web_endpoint
    }
    identity = {
      type = azurerm_storage_account.this.identity[0].type
      id   = tolist(azurerm_storage_account.this.identity[0].identity_ids)[0]
    }
  }
}

output "private_endpoints_details" {
  description = "Private endpoints details"
  value = { for key, service in local.private_endpoint_services :
    module.private_endpoint.private_dns_zone_soa_records[key] => module.private_endpoint.private_endpoint_ids[key]
  }
}
