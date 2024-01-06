resource "aws_s3_bucket" "root" {
  bucket        = var.workspace_name
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "root" {
  bucket = aws_s3_bucket.root.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "root" {
  bucket = aws_s3_bucket.root.bucket
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

data "databricks_aws_bucket_policy" "root" {
  bucket = aws_s3_bucket.root.bucket
}

resource "aws_s3_bucket_policy" "root" {
  bucket = aws_s3_bucket.root.id
  policy = data.databricks_aws_bucket_policy.root.json
}

resource "databricks_mws_storage_configurations" "default" {
  provider                   = databricks.mws
  account_id                 = var.databricks_account_id
  bucket_name                = aws_s3_bucket.root.bucket
  storage_configuration_name = "${var.workspace_name}-default"
}