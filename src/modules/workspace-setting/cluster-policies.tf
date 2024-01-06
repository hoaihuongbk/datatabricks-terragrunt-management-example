locals {
  interactive_cluster_policy = {
    "custom_tags.Team" : {
      "type" : "unlimited"
    },
    "cluster_type" : {
      "type" : "fixed",
      "value" : "all-purpose"
    },
    "runtime_engine" : {
      "type" : "fixed",
      "value" : "STANDARD",
      "hidden" : true
    },
    "autoscale.min_workers" : {
      "type" : "range",
      "maxValue" : 2,
      "defaultValue" : 1
    },
    "autoscale.max_workers" : {
      "type" : "range",
      "maxValue" : 100,
      "defaultValue" : 10
    },
    "autotermination_minutes" : {
      "type" : "range",
      "minValue" : 10,
      "maxValue" : 60,
      "defaultValue" : 30
    }
  }

  job_cluster_policy = {
    "custom_tags.Team" : {
      "type" : "unlimited"
    },
    "cluster_type" : {
      "type" : "fixed",
      "value" : "job"
    },
    "runtime_engine" : {
      "type" : "fixed",
      "value" : "STANDARD",
      "hidden" : true
    },
    "autoscale.min_workers" : {
      "type" : "range",
      "maxValue" : 2,
      "defaultValue" : 1
    },
    "autoscale.max_workers" : {
      "type" : "range",
      "maxValue" : 500,
      "defaultValue" : 10
    }
  }

}

resource "databricks_cluster_policy" "interactive_cluster_policy" {
  provider   = databricks.workspace
  name       = "interactive_cluster_policy"
  definition = jsonencode(local.interactive_cluster_policy)
}

resource "databricks_cluster_policy" "job_cluster_policy" {
  provider   = databricks.workspace
  name       = "job_cluster_policy"
  definition = jsonencode(local.job_cluster_policy)
}
