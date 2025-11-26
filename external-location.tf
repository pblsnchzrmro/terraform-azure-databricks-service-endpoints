resource "databricks_storage_credential" "storage_credential" {
  provider       = databricks.workspace
  name           = "sc-${var.project_name}-external"
  metastore_id   = data.databricks_metastore.metastore.id
  isolation_mode = "ISOLATION_MODE_ISOLATED"
  comment        = "Managed identity credential managed by TF"

  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.storage.id
    managed_identity_id = azurerm_user_assigned_identity.storage.id
  }

  depends_on = [azurerm_databricks_access_connector.storage, azurerm_storage_account.adls]
}

resource "databricks_external_location" "external_location" {
  provider        = databricks.workspace
  name            = "el-${var.project_name}-external"
  metastore_id    = data.databricks_metastore.metastore.id
  url             = format("abfss://%s@%s.dfs.core.windows.net/", azurerm_storage_container.data.name, azurerm_storage_account.adls.name)
  credential_name = databricks_storage_credential.storage_credential.name
  isolation_mode  = "ISOLATION_MODE_ISOLATED"
  force_destroy   = true
  comment         = "Managed by TF"

  depends_on = [databricks_storage_credential.storage_credential]
}
