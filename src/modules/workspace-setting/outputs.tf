output "cluster_policies" {
  description = "Map of cluster policy (key -> id)"
  value = {
    interactive_cluster_policy = databricks_cluster_policy.interactive_cluster_policy.id
    job_cluster_policy         = databricks_cluster_policy.job_cluster_policy.id
  }
}