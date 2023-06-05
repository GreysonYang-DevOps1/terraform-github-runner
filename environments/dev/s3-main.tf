# AWS S3

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.11.0"

  bucket        = "${lower(local.name)}-${random_string.s3.result}"
  acl           = "private"
  force_destroy = true

  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  versioning = {
    enabled = false
  }

  tags = local.common_tags

}

resource "random_string" "s3" {
  special = false
  upper   = false
  length  = 8
}