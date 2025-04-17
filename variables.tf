variable "storage_account_name" {
  description = "The name of the storage account. Must be between 3 and 24 characters in length and use numbers and lower-case letters only."
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
