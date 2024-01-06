data "databricks_aws_assume_role_policy" "default" {
  external_id = var.databricks_account_id
}

resource "aws_iam_role" "cross_account_role" {
  name               = var.workspace_name
  assume_role_policy = data.databricks_aws_assume_role_policy.default.json
  tags               = var.tags
}

data "databricks_aws_crossaccount_policy" "default" {}

resource "aws_iam_role_policy" "default" {
  name   = "${var.workspace_name}-default"
  role   = aws_iam_role.cross_account_role.id
  policy = data.databricks_aws_crossaccount_policy.default.json
}

resource "databricks_mws_credentials" "default" {
  provider         = databricks.mws
  account_id       = var.databricks_account_id
  role_arn         = aws_iam_role.cross_account_role.arn
  credentials_name = "${var.workspace_name}-default"
  depends_on       = [aws_iam_role_policy.default]
}