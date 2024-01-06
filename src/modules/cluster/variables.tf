variable "cluster_name" {
  description = "Team cluster name. Each team should own dedicated cluster & resources"
}

variable "databricks_spark_version" {
  description = "The Databricks Spark Runtime Version"
  default     = "10.4.x-scala2.12"
}

variable "node_type_id" {
  description = "The node type id. E.g r5.xlarge, r6g.xlarge"
  default     = "r6g.2xlarge"
}

variable "driver_node_type_id" {
  description = "The driver node type id. E.g r5.xlarge, r6g.xlarge"
  default     = null
}

variable "cluster_policy_id" {
  description = "The default cluster policy id"
  default     = "interactive_cluster_policy"
}

variable "autotermination_minutes" {
  description = "This cluster should be terminated after x minutes if no job runs on it. Default: 30"
  default     = 30
}

variable "is_pinned" {
  description = "Mark this true if you want to pin this cluster. Max pinned cluster is 70"
  default     = false
}

variable "min_workers" {
  description = "The minimum workers for cluster. Default: 1"
  default     = 1
}

variable "max_workers" {
  description = "The maximum workers for cluster. Default: 10"
  default     = 10
}

variable "additional_cluster_spark_config" {
  description = "Map of additional spark config would be add to team cluster"
  type        = map(any)
  default     = {}
}

variable "additional_cluster_envs" {
  description = "The map of cluster system environment"
  type        = map(any)
  default     = {}
}

variable "team_owner_group" {
  description = "The team owner group name who would have the full permission to workspace resources e.g cluster, directory"
}

variable "tags" {
  description = "AWS tags"
  type        = map(string)
}
