# create s3 bucket as a workspace

resource "aws_s3_bucket" "tf-s3" {
  bucket = "${var.resource_prefix}"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "tf-s3-conf" {
  bucket = aws_s3_bucket.tf-s3.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

