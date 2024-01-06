terraform {
  source = "${get_path_to_repo_root()}//modules/workspace"
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

locals {
  env_vars       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  workspace_name = format("%s-%s", local.env_vars.locals.env, local.env_vars.app_name)

  tags = {
    Name = local.workspace_name
    Env  = local.env_vars.locals.env
  }
}

inputs {
  tags   = local.tags
  env    = local.env_vars.locals.env
  region = local.env_vars.locals.region
  vpc_id = local.env_vars.locals.vpc_id
  private_subnets = [
    local.env_vars.locals.private_subnet_1a, local.env_vars.locals.private_subnet_1b,
    local.env_vars.locals.private_subnet_1c
  ]
  databricks_account_id = local.env_vars.locals.databricks_account_id
  workspace_name        = local.workspace_name
}