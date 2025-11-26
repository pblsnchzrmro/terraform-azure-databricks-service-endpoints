resource "azurerm_databricks_access_connector" "workspace" {
  name                = "dac-${var.project_name}-workspace"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.azure_region

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_databricks_workspace" "workspace" {
  name                                  = "dbw-${var.project_name}"
  resource_group_name                   = azurerm_resource_group.rg.name
  managed_resource_group_name           = "rg-${var.project_name}-databricks-managed"
  location                              = var.azure_region
  sku                                   = "premium"
  tags                                  = var.tags
  public_network_access_enabled         = var.public_network_access_enabled
  network_security_group_rules_required = var.network_security_group_rules_required
  customer_managed_key_enabled          = true
  default_storage_firewall_enabled      = var.default_storage_firewall_enabled
  access_connector_id                   = azurerm_databricks_access_connector.workspace.id

  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = azurerm_virtual_network.vnet.id
    private_subnet_name                                  = azurerm_subnet.private.name
    public_subnet_name                                   = azurerm_subnet.public.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.public.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private.id
    storage_account_name                                 = var.dbfs_storage_account
  }

  depends_on = [
    azurerm_subnet_network_security_group_association.public,
    azurerm_subnet_network_security_group_association.private
  ]
}

data "databricks_metastore" "metastore" {
  provider = databricks.accounts
  name     = var.databricks_metastore
}

resource "databricks_metastore_assignment" "workspace" {
  provider     = databricks.accounts
  metastore_id = data.databricks_metastore.metastore.id
  workspace_id = azurerm_databricks_workspace.workspace.workspace_id
  depends_on   = [azurerm_databricks_workspace.workspace, data.databricks_metastore.metastore]
}
