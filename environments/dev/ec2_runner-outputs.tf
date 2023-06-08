# Outputs for EC2 GitHub Runner Host

output "ec2_runner_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2_runner.id
}

output "ec2_runner_ssh_key_url" {
  description = "URl for download EC2(runner) SSH key"
  value       = "https://${module.s3_bucket.s3_bucket_bucket_domain_name}/${aws_s3_object.ec2_runner-key.key}"
}

output "ec2_runner_ssh_command" {
  description = "URl for SSH EC2(runner) server"
  value       = "ssh Administrator@${module.ec2_runner.private_ip}"
}