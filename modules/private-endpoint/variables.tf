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

# Private Endpoint Variables
variable "virtual_network_id" {
  description = "The ID of the virtual network to which the private endpoint will be connected."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to which the private endpoint will be connected."
  type        = string
}

variable "services" {
  description = "A map of services to create private endpoints for."
  type = map(object({
    name     = string
    id       = string
    type     = string
    dns_name = string
  }))
}
