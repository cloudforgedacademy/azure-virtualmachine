terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

}

provider "azurerm" {
  alias = ""
  features {}
  subscription_id                 = ""
  resource_provider_registrations = "none"
}
