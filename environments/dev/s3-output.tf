# Outputs for S3

# S3 Domain Name
output "s3_name" {
  description = "The Name of the S3"
  value       = module.s3_bucket.s3_bucket_bucket_domain_name
}

# S3 ARN
output "s3_arn" {
  description = "The ARN of the VPC"
  value       = module.s3_bucket.s3_bucket_arn
}