# Outputs for EC2 Bastion Host

output "ec2_bastion_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2_bastion.id
}

output "ec2_bastion_ssh_key_url" {
  description = "URl for download EC2(Bastion) SSH key"
  value       = "https://${module.s3_bucket.s3_bucket_bucket_domain_name}/${aws_s3_object.ec2_bastion-key.key}"
}

output "ec2_bastion_ssh_command" {
  description = "URl for SSH EC2(Bastion) server"
  value       = "ssh -i ${var.ec2_bastion_instance_keypair} ec2-user@${module.ec2_bastion.public_ip}"
}