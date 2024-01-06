resource "databricks_cluster" "default" {
  provider                = databricks.workspace
  cluster_name            = var.cluster_name
  spark_version           = var.databricks_spark_version
  node_type_id            = var.node_type_id
  driver_node_type_id     = (var.driver_node_type_id != null) ? var.driver_node_type_id : var.node_type_id
  policy_id               = var.cluster_policy_id
  autotermination_minutes = var.autotermination_minutes
  is_pinned               = var.is_pinned

  autoscale {
    min_workers = var.min_workers
    max_workers = var.max_workers
  }

  spark_conf     = var.additional_cluster_spark_config
  spark_env_vars = var.additional_cluster_envs

  custom_tags = var.tags

  # Apply default value from policy
  apply_policy_default_values = true
}