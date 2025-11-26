output "databricks_workspace_url" {
  description = "URL of the Databricks workspace"
  value       = "https://${azurerm_databricks_workspace.workspace.workspace_url}/"
}

output "databricks_workspace_id" {
  description = "ID of the Databricks workspace"
  value       = azurerm_databricks_workspace.workspace.workspace_id
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.rg.id
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "storage_account_id" {
  description = "ID of the ADLS storage account"
  value       = azurerm_storage_account.adls.id
}

output "storage_account_name" {
  description = "Name of the ADLS storage account"
  value       = azurerm_storage_account.adls.name
}

output "storage_container_name" {
  description = "Name of the storage container"
  value       = azurerm_storage_container.data.name
}

output "storage_credential_name" {
  description = "Name of the Databricks storage credential"
  value       = databricks_storage_credential.storage_credential.name
}

output "external_location_name" {
  description = "Name of the Databricks external location"
  value       = databricks_external_location.external_location.name
}

output "external_location_url" {
  description = "URL of the Databricks external location"
  value       = databricks_external_location.external_location.url
}

output "metastore_id" {
  description = "ID of the Databricks metastore"
  value       = data.databricks_metastore.metastore.id
}

output "ncc_id" {
  description = "ID of the Network Connectivity Configuration"
  value       = databricks_mws_network_connectivity_config.ncc.network_connectivity_config_id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = azurerm_subnet.private.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = azurerm_subnet.public.id
}
