output "virtual_network_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  description = "List of subnet IDs"
  value       = { for key, subnet in var.subnets : key => azurerm_subnet.this[key].id }
}
