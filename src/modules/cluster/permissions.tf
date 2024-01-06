resource "databricks_permissions" "cluster_perm" {
  provider   = databricks.workspace
  cluster_id = databricks_cluster.default.cluster_id

  access_control {
    group_name       = var.team_owner_group
    permission_level = "CAN_MANAGE"
  }

  depends_on = [databricks_cluster.default]
}