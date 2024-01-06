terraform {
  source = "${get_path_to_repo_root()}//modules/cluster"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

remote_state {
  backend = "s3"
  config = {
    bucket                = local.env_vars.locals.terraform_state_bucket
    key                   = "${path_relative_to_include("root")}/terraform.tfstate"
    region                = local.env_vars.locals.region
    dynamodb_table        = local.env_vars.locals.terraform_state_dynamodb
    disable_bucket_update = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

include "providers" {
  path = find_in_parent_folders("providers.hcl")
}

# This setting depends on workspace (name: business)
dependency "workspace_remote_state" {
  config_path = "../../workspace/business"
}

include "workspace_providers" {
  path = find_in_parent_folders("workspace.hcl")
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  tags = {
    Team = local.env_vars.locals.app_name
    Env  = local.env_vars.locals.env
  }
}

inputs {
  tags             = local.tags
  env              = local.env_vars.locals.env
  cluster_name     = local.env_vars.locals.app_name
  team_owner_group = "team-c"
  node_type_id     = "r6g.4xlarge"
  max_workers      = 30
}