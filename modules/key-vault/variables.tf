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

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send logs to."
  type        = string
}

variable "allowed_ip" {
  description = "The IP address that is allowed to access the Key Vault."
  type        = string
}

# Key Vault Variables
variable "key_vault_sku_name" {
  description = "The SKU name for the Key Vault. Can be either 'standard' or 'premium'."
  type        = string
  default     = "standard"
}
