variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the storage account."
  type        = map(string)
  default = {
    "environment" = "lab"
  }
}

variable "prefix" {
  description = "The prefix to use for the resources name."
  type        = string
  default     = "lab"
}

variable "network" {
  description = "The network configuration for the storage account."
  type = map(object({
    id                = number
    name              = string
    additional_bits   = number
    service_endpoints = optional(list(string), [])
    nsg_rules = map(object({
      name                       = string
      priority                   = number
      direction                  = optional(string, "Inbound")
      access                     = optional(string, "Deny")
      protocol                   = optional(string, "Tcp")
      source_port_range          = optional(string, "*")
      destination_port_range     = optional(string, "*")
      source_address_prefix      = optional(string, "*")
      destination_address_prefix = optional(string, "*")
    }))
  }))
  default = {
    pe = {
      id              = 1
      name            = "pe"
      additional_bits = 8
      nsg_rules       = {}
    }
    client = {
      id                = 2
      name              = "client"
      additional_bits   = 8
      service_endpoints = ["Microsoft.Storage"]
      nsg_rules = {
        ssh = {
          name                       = "AllowSSH"
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
        http = {
          name                       = "AllowHTTP"
          priority                   = 120
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      }
    }
  }
}
