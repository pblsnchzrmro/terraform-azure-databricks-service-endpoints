resource "databricks_mws_network_connectivity_config" "ncc" {
  provider = databricks.accounts
  name     = "ncc-${azurerm_databricks_workspace.workspace.name}"
  region   = var.azure_region
}

resource "databricks_mws_ncc_binding" "ncc_binding" {
  provider                       = databricks.accounts
  network_connectivity_config_id = databricks_mws_network_connectivity_config.ncc.network_connectivity_config_id
  workspace_id                   = azurerm_databricks_workspace.workspace.workspace_id
}

locals {
  all_storage_subnets = [for conf in databricks_mws_network_connectivity_config.ncc.egress_config :
    [for rule in conf.default_rules :
      [for se_rule in rule.azure_service_endpoint_rule :
        se_rule.subnets if contains(se_rule.target_services, "AZURE_BLOB_STORAGE")
      ]
    ]
  ]
  uniq_storage_subnets = distinct(flatten(local.all_storage_subnets))
}
