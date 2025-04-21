# Terraform module - Azure Storage Account

## Examples

- [Basic](examples/basic/)

## Links

### Storage accounts

- https://azure.github.io/Azure-Verified-Modules/indexes/terraform/tf-resource-modules/
- https://github.com/Azure/terraform-azurerm-avm-res-storage-storageaccount
- https://github.com/claranet/terraform-azurerm-storage-account
- https://learn.microsoft.com/en-us/azure/storage/
- https://azuretechinsider.com/secure-data-advanced-azure-storage-security/
- https://learn.microsoft.com/en-us/azure/well-architected/service-guides/azure-blob-storage

### Availability

- https://learn.microsoft.com/en-us/azure/storage/blobs/access-tiers-overview
- https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy

### Networking

- https://techcommunity.microsoft.com/blog/coreinfrastructureandsecurityblog/service-endpoints-vs-private-endpoints/3962134
- https://techcommunity.microsoft.com/blog/fasttrackforazureblog/azure-private-endpoint-vs-service-endpoint-a-comprehensive-guide/4363095

### Authentication & authorization

- https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/overview
- https://learn.microsoft.com/en-us/azure/storage/common/authorize-data-access

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =4.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =4.26.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./modules/key-vault | n/a |
| <a name="module_monitor"></a> [monitor](#module\_monitor) | ./modules/monitor | n/a |
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | ./modules/private-endpoint | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./modules/vnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/key_vault_key) | resource |
| [azurerm_monitor_diagnostic_setting.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.storage_account_blob](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.storage_account_file](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/storage_account) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | The replication type for the storage account. Can be 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS', or 'RAGZRS'. | `string` | `"GRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | The account tier for the storage account. Can be either 'Standard' or 'Premium'. | `string` | `"Standard"` | no |
| <a name="input_allowed_ip"></a> [allowed\_ip](#input\_allowed\_ip) | The IP address that is allowed to access the Storage Account, Key Vault. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure location where the storage account will be created. | `string` | n/a | yes |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum TLS version for the storage account. Can be 'TLS1\_0', 'TLS1\_1', or 'TLS1\_2'. | `string` | `"TLS1_2"` | no |
| <a name="input_network"></a> [network](#input\_network) | The network configuration for the storage account. | <pre>map(object({<br/>    id                = number<br/>    name              = string<br/>    additional_bits   = number<br/>    service_endpoints = optional(list(string), [])<br/>    nsg_rules = map(object({<br/>      name                       = string<br/>      priority                   = number<br/>      direction                  = optional(string, "Inbound")<br/>      access                     = optional(string, "Deny")<br/>      protocol                   = optional(string, "Tcp")<br/>      source_port_range          = optional(string, "*")<br/>      destination_port_range     = optional(string, "*")<br/>      source_address_prefix      = optional(string, "*")<br/>      destination_address_prefix = optional(string, "*")<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix to use for the resources name. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the storage account. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the storage account. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_endpoints_details"></a> [private\_endpoints\_details](#output\_private\_endpoints\_details) | Private endpoints details |
| <a name="output_storage_account_details"></a> [storage\_account\_details](#output\_storage\_account\_details) | Storage account details |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
