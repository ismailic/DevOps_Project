terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  # Hadi hya li ghadi t-khdem lik f l-Sandbox
  skip_provider_registration = true

  features {}
}



