generate "workspace_provider" {
  path      = "workspace_provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
# use module reference for terraform to establish dependency
provider "databricks" {
  alias      = "workspace"
  host       = "${dependency.workspace_remote_state.outputs.workspace_url}"
   client_id     = "<REPLACE YOUR DATABRICKS CLIENT ID HERE>"
  client_secret = "<REPLACE YOUR DATABRICKS CLIENT SECRET HERE>"
}

EOF
}