# Terraform module - Azure Storage Account

## Examples

- [Basic](examples/basic/)

## Links

- https://azure.github.io/Azure-Verified-Modules/indexes/terraform/tf-resource-modules/
- https://github.com/Azure/terraform-azurerm-avm-res-storage-storageaccount
- https://github.com/claranet/terraform-azurerm-storage-account
- https://techcommunity.microsoft.com/blog/fasttrackforazureblog/azure-private-endpoint-vs-service-endpoint-a-comprehensive-guide/4363095
- https://learn.microsoft.com/en-us/azure/storage/
- https://azuretechinsider.com/secure-data-advanced-azure-storage-security/
- https://learn.microsoft.com/en-us/azure/well-architected/service-guides/azure-blob-storage

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

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | The replication type for the storage account. Can be 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS', or 'RAGZRS'. | `string` | `"GRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | The account tier for the storage account. Can be either 'Standard' or 'Premium'. | `string` | `"Standard"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure location where the storage account will be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the storage account. | `string` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the storage account. Must be between 3 and 24 characters in length and use numbers and lower-case letters only. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the storage account. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the storage account. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
