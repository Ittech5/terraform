# Terraform Block
terraform {
  required_version = "=1.4.2"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.48"
     }
      random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}
# Provider Block
provider "azurerm" {
  features {}
}
# Random String Resource
resource "random_string" "my_random" {
  length = 6
  upper = false
  special = false
  lower = false 
}