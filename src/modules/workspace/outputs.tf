output "workspace_url" {
  description = "Databricks workspace url"
  value       = databricks_mws_workspaces.this.workspace_url
}

output "workspace_number_id" {
  description = "Databricks workspace id (number)"
  value       = databricks_mws_workspaces.this.workspace_id
}
