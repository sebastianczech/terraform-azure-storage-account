output "private_endpoint_ids" {
  description = "List of private endpoint IDs"
  value       = { for key, service in var.services : key => azurerm_private_endpoint.this[key].id }
}

output "private_dns_zone_soa_records" {
  description = "List of private DNS zone SOA records"
  value       = { for key, service in var.services : key => azurerm_private_dns_zone.this[key].soa_record[0].fqdn }
}
