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
