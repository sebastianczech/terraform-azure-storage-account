# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

# https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http
data "http" "this" {
  url = "https://api.ipify.org" # "https://ifconfig.me"
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "this" {
  length  = 16
  special = false
}

module "storage_account" {
  source = "../../"

  # names are generated from the resource group name and abbreviation from https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations
  storage_account_name = "${substr(replace(data.azurerm_resource_group.this.name, "-", ""), 0, 21)}st"
  key_vault_name       = "${random_string.this.result}-kv"
  allowed_ip           = "${data.http.this.response_body}/32"

  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location

  tags = var.tags
}
