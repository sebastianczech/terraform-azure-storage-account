output "resource_group_id" {
  description = "The ID of the resource group in which the storage account was created."
  value       = data.azurerm_resource_group.this.id
}

output "storage_account_details" {
  description = "Storage account details"
  value       = module.storage_account.storage_account_details
}

output "private_endpoints_details" {
  description = "Private endpoints details"
  value       = module.storage_account.private_endpoints_details
}
