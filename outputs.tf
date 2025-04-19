output "storage_account_id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.this.id
}

output "private_endpoints_details" {
  description = "Private endpoints details"
  value = { for key, service in local.private_endpoint_services :
    module.private_endpoint.private_dns_zone_soa_records[key] => module.private_endpoint.private_endpoint_ids[key]
  }
}
