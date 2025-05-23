# Example - basic storage account

## Usage

### Authentication

```bash
export ARM_CLIENT_ID="00000000-0000-0000-0000-000000000000"
export ARM_CLIENT_SECRET="12345678-0000-0000-0000-000000000000"
export ARM_TENANT_ID="10000000-0000-0000-0000-000000000000"
export ARM_SUBSCRIPTION_ID="20000000-0000-0000-0000-000000000000"
```

or

```bash
az login --use-device-code
export ARM_SUBSCRIPTION_ID=`az account show --query id --output tsv`
export ARM_TENANT_ID=`az account show --query tenantId --output tsv`
export TF_VAR_resource_group_name=`az group list --query "[0].name" --output tsv`
```

### Terraform deployment

```bash
terraform init
terraform apply
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =4.26.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | =3.4.5 |
| <a name="requirement_random"></a> [random](#requirement\_random) | =3.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =4.26.0 |
| <a name="provider_http"></a> [http](#provider\_http) | =3.4.5 |
| <a name="provider_random"></a> [random](#provider\_random) | =3.7.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [random_string.this](https://registry.terraform.io/providers/hashicorp/random/3.7.1/docs/resources/string) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.26.0/docs/data-sources/resource_group) | data source |
| [http_http.this](https://registry.terraform.io/providers/hashicorp/http/3.4.5/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network"></a> [network](#input\_network) | The network configuration for the storage account. | <pre>map(object({<br/>    id                = number<br/>    name              = string<br/>    additional_bits   = number<br/>    service_endpoints = optional(list(string), [])<br/>    nsg_rules = map(object({<br/>      name                       = string<br/>      priority                   = number<br/>      direction                  = optional(string, "Inbound")<br/>      access                     = optional(string, "Deny")<br/>      protocol                   = optional(string, "Tcp")<br/>      source_port_range          = optional(string, "*")<br/>      destination_port_range     = optional(string, "*")<br/>      source_address_prefix      = optional(string, "*")<br/>      destination_address_prefix = optional(string, "*")<br/>    }))<br/>  }))</pre> | <pre>{<br/>  "client": {<br/>    "additional_bits": 8,<br/>    "id": 2,<br/>    "name": "client",<br/>    "nsg_rules": {<br/>      "http": {<br/>        "access": "Allow",<br/>        "destination_address_prefix": "*",<br/>        "destination_port_range": "80",<br/>        "direction": "Inbound",<br/>        "name": "AllowHTTP",<br/>        "priority": 120,<br/>        "protocol": "Tcp",<br/>        "source_address_prefix": "*",<br/>        "source_port_range": "*"<br/>      },<br/>      "ssh": {<br/>        "access": "Allow",<br/>        "destination_address_prefix": "*",<br/>        "destination_port_range": "22",<br/>        "direction": "Inbound",<br/>        "name": "AllowSSH",<br/>        "priority": 110,<br/>        "protocol": "Tcp",<br/>        "source_address_prefix": "*",<br/>        "source_port_range": "*"<br/>      }<br/>    },<br/>    "service_endpoints": [<br/>      "Microsoft.Storage"<br/>    ]<br/>  },<br/>  "pe": {<br/>    "additional_bits": 8,<br/>    "id": 1,<br/>    "name": "pe",<br/>    "nsg_rules": {}<br/>  }<br/>}</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix to use for the resources name. | `string` | `"lab"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the storage account. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the storage account. | `map(string)` | <pre>{<br/>  "environment": "lab"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_endpoints_details"></a> [private\_endpoints\_details](#output\_private\_endpoints\_details) | Private endpoints details |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | The ID of the resource group in which the storage account was created. |
| <a name="output_storage_account_details"></a> [storage\_account\_details](#output\_storage\_account\_details) | Storage account details |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
