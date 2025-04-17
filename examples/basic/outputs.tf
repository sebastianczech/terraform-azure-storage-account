output "resource_group_id" {
  description = "The ID of the resource group in which the storage account was created."
  value       = data.azurerm_resource_group.this.id
}

output "storage_account_id" {
  description = "The ID of the storage account."
  value       = module.storage_account.storage_account_id
}
