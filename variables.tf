# Common Variables
variable "prefix" {
  description = "The prefix to use for the resources name."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the storage account."
  type        = map(string)
  default     = {}
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
}

variable "location" {
  description = "The Azure location where the storage account will be created."
  type        = string
}

variable "allowed_ip" {
  description = "The IP address that is allowed to access the Storage Account, Key Vault."
  type        = string
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
}

# Storage Account Variables
variable "account_tier" {
  description = "The account tier for the storage account. Can be either 'Standard' or 'Premium'."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The replication type for the storage account. Can be 'LRS', 'GRS', 'RAGRS', 'ZRS', 'GZRS', or 'RAGZRS'."
  type        = string
  default     = "GRS"
}

variable "min_tls_version" {
  description = "The minimum TLS version for the storage account. Can be 'TLS1_0', 'TLS1_1', or 'TLS1_2'."
  type        = string
  default     = "TLS1_2"
}
