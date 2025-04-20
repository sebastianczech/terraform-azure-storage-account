output "storage_account_details" {
  description = "Storage account details"
  value = {
    id                     = azurerm_storage_account.this.id
    name                   = azurerm_storage_account.this.name
    primary_blob_endpoint  = azurerm_storage_account.this.primary_blob_endpoint
    primary_queue_endpoint = azurerm_storage_account.this.primary_queue_endpoint
    primary_table_endpoint = azurerm_storage_account.this.primary_table_endpoint
    primary_file_endpoint  = azurerm_storage_account.this.primary_file_endpoint
    primary_dfs_endpoint   = azurerm_storage_account.this.primary_dfs_endpoint
    primary_web_endpoint   = azurerm_storage_account.this.primary_web_endpoint
  }
}

output "private_endpoints_details" {
  description = "Private endpoints details"
  value = { for key, service in local.private_endpoint_services :
    module.private_endpoint.private_dns_zone_soa_records[key] => module.private_endpoint.private_endpoint_ids[key]
  }
}
