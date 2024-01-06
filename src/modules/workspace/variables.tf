variable "region" {
  description = "AWS region"
}

variable "vpc_id" {
  description = "AWS VPC id"
}

variable "private_subnets" {
  description = "AWS VPC private subnets"
  type        = list(string)
}

variable "tags" {
  description = "Your organization tags"
  type        = map(string)
}

variable "workspace_name" {
  description = "Your workspace name (no spacing)"
}

variable "databricks_account_id" {
  description = "The Databricks account ID (get from account console)"
}

