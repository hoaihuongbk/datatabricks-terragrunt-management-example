prevent_destroy = true

terraform_version_constraint = "= 1.3.6"

terragrunt_version_constraint = "= 0.42.5"

retryable_errors = [
  ".*Failed to load plugin schemas.*"
]
