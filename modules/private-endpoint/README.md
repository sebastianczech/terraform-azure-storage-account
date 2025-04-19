# Terraform module - Azure Private Endpoint

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
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The Azure location where the storage account will be created. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix to use for the resources name. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the storage account. | `string` | n/a | yes |
| <a name="input_services"></a> [services](#input\_services) | A map of services to create private endpoints for. | <pre>map(object({<br/>    name     = string<br/>    id       = string<br/>    type     = string<br/>    dns_name = string<br/>  }))</pre> | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet to which the private endpoint will be connected. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the storage account. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | The ID of the virtual network to which the private endpoint will be connected. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_dns_zone_soa_records"></a> [private\_dns\_zone\_soa\_records](#output\_private\_dns\_zone\_soa\_records) | List of private DNS zone SOA records |
| <a name="output_private_endpoint_ids"></a> [private\_endpoint\_ids](#output\_private\_endpoint\_ids) | List of private endpoint IDs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
