resource "databricks_mws_workspaces" "this" {
  provider       = databricks.mws
  account_id     = var.databricks_account_id
  aws_region     = var.region
  workspace_name = var.workspace_name

  credentials_id           = databricks_mws_credentials.default.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.default.storage_configuration_id
  network_id               = databricks_mws_networks.default.network_id

  depends_on = [databricks_mws_networks.default]
}