# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}-vnet"
  address_space       = [var.network_ip_range]
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                              = "${each.value.name}-snet"
  resource_group_name               = var.resource_group_name
  virtual_network_name              = azurerm_virtual_network.this.name
  address_prefixes                  = [cidrsubnet(var.network_ip_range, each.value.additional_bits, each.value.id)]
  private_endpoint_network_policies = "Disabled"
  service_endpoints                 = length(each.value.service_endpoints) > 0 ? each.value.service_endpoints : null
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
resource "azurerm_network_security_group" "this" {
  for_each = var.subnets

  name                = "${var.prefix}-${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

locals {
  subnet_rules = { for i in flatten([
    for subnet_key, subnet in var.subnets : [
      for rule_key, rule in subnet.nsg_rules : {
        subnet_key = subnet_key
        rule_key   = rule_key
        rule       = rule
      }
    ]]) : "${i.subnet_key}_${i.rule_key}" => {
    subnet_key = i.subnet_key
    rule_key   = i.rule_key
    rule       = i.rule
  } }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule
resource "azurerm_network_security_rule" "this" {
  for_each = local.subnet_rules

  name                        = "${var.prefix}-${each.value.rule.name}"
  network_security_group_name = "${var.prefix}-${each.value.subnet_key}-nsg"
  resource_group_name         = var.resource_group_name
  priority                    = each.value.rule.priority
  direction                   = lookup(each.value.rule, "direction", "Inbound")
  access                      = lookup(each.value.rule, "access", "Deny")
  protocol                    = lookup(each.value.rule, "protocol", "Tcp")
  source_port_range           = lookup(each.value.rule, "source_port_range", "*")
  destination_port_range      = lookup(each.value.rule, "destination_port_range", "*")
  source_address_prefix       = lookup(each.value.rule, "source_address_prefix", "*")
  destination_address_prefix  = lookup(each.value.rule, "destination_address_prefix", "*")

  depends_on = [azurerm_network_security_group.this]
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association.html
resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = var.subnets

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}
