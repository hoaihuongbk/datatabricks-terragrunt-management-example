terraform {
  source = "${get_path_to_repo_root()}//modules/workspace-setting"
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

# This setting depends on workspace (name: development)
dependency "workspace_remote_state" {
  config_path = "../../workspace/development"
}

include "workspace_providers" {
  path = find_in_parent_folders("workspace.hcl")
}

locals {
  env_vars       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  workspace_name = format("%s-%s", local.env_vars.locals.env, local.env_vars.app_name)

  tags = {
    Name = local.workspace_name
    Env  = local.env_vars.locals.env
  }
}

inputs {
  env                 = local.env_vars.locals.env
  workspace_number_id = dependency.workspace_remote_state.outputs.workspace_number_id

  admin_groups = ["admin-1", "admin-2"]
  user_groups  = ["dev-a", "dev-b", "dev-c"]
}