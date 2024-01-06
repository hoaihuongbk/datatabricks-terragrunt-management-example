variable "workspace_number_id" {
  description = "Databricks workspace ID as number"
}

variable "whitelisted_ips" {
  description = "The list of public IPs to be whitelisted to access AWS Databricks"
  type        = list(string)
  default     = []
}

variable "admin_groups" {
  description = "List of admin groups"
  type        = list(string)
}

variable "user_groups" {
  description = "List of user groups"
  type        = list(string)
}
