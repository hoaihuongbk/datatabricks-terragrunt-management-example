locals {
  app_name                 = format("%s-%s", "databricks", "${basename(get_original_terragrunt_dir())}")
  region                   = "ap-southeast-1"
  account_id               = "<REPLACE YOUR AWS ACCOUNT ID HERE>"
  env                      = "dev"
  terraform_state_bucket   = "<REPLACE YOUR TERRAFORM S3 BUCKET HERE>"
  terraform_state_dynamodb = "<REPLACE YOUR TERRAFORM LOCK DYNAMO TABLE NAME HERE>"

  # Network resources
  vpc_id            = "<REPLACE YOUR AWS VPC ID HERE>"
  private_subnet_1a = "<REPLACE YOUR AWS VPC SUBNET 1A HERE>"
  private_subnet_1b = "<REPLACE YOUR AWS VPC SUBNET 1B HERE>"
  private_subnet_1c = "<REPLACE YOUR AWS VPC SUBNET 1C HERE>"

  databricks_account_id = "<REPLACE YOUR DATABRICKS ACCOUNT ID HERE>"
}
