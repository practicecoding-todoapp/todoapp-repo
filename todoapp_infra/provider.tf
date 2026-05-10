#aao sunau pyar ki ek kahani 



terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.72.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "56011ccb-a473-4dd5-83a1-6c6f6bc01bf1"
}