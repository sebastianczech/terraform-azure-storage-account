# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
resource "azurerm_private_endpoint" "this" {
  for_each = var.services

  name                = "${var.prefix}-${each.value.name}-pep"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.prefix}-${each.value.name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = each.value.id
    subresource_names              = [each.value.type]
  }

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone
resource "azurerm_private_dns_zone" "this" {
  for_each = var.services

  name                = each.value.dns_name
  resource_group_name = var.resource_group_name
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.services

  name                  = "${var.prefix}-${each.value.name}-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this[each.key].name
  virtual_network_id    = var.virtual_network_id
}
