generate "aws_provider" {
  path      = "aws_provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
  region = "ap-southeast-1"

  assume_role {
    role_arn     = "<REPLACE THE IAM ROLE THAT HAS PERMISSION TO ACCESS S3 BACKEND HERE>"
    session_name = "terraform"
  }
}
EOF
}

generate "databricks_provider" {
  path      = "databricks_provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
# use module reference for terraform to establish dependency
provider "databricks" {
  alias      = "mws"
  account_id = "<REPLACE YOUR DATABRICKS ACCOUNT ID HERE>"
  host       = "https://accounts.cloud.databricks.com"
  client_id     = "<REPLACE YOUR DATABRICKS CLIENT ID HERE>"
  client_secret = "<REPLACE YOUR DATABRICKS CLIENT SECRET HERE>"
}

EOF
}
