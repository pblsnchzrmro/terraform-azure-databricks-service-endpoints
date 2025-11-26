terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.31.0"
    }

    databricks = {
      source  = "databricks/databricks"
      version = ">=1.81.1"
    }
  }
}

provider "azurerm" {
  subscription_id = var.azure_subscription_id
  features {}
}

provider "databricks" {
  alias      = "accounts"
  host       = var.databricks_account_host
  account_id = var.databricks_account_id
}

provider "databricks" {
  alias = "workspace"
  host  = azurerm_databricks_workspace.workspace.workspace_url
}
