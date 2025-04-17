terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "=3.7.1"
    }
    http = {
      source  = "hashicorp/http"
      version = "=3.4.5"
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
}
