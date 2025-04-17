data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

module "storage_account" {
  source = "../../"

  storage_account_name = "${substr(replace(data.azurerm_resource_group.this.name, "-", ""), 0, 21)}sa"
  resource_group_name  = data.azurerm_resource_group.this.name
  location             = data.azurerm_resource_group.this.location

  tags = var.tags
}
