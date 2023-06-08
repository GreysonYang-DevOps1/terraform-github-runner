# Generic Variables
aws_region       = "ap-southeast-2"
environment      = "dev"
business_divsion = "DevOps1"

# EC2 Bastion Host Variables
instance_name = "Bastion_Host"
instance_type = "t2.small"
ami_id        = "ami-06bb074d1e196d0d4"
ec2_bastion_instance_keypair = "bastion-ec2-key"

# EC2 GitHub Runner Variables
ec2_runner_instance_name = "EC2-Self-Hosted-Runner-Windows"
ec2_runner_instance_type = "t2.medium"
ec2_runner_ami_id        = "ami-05edfd48928db6e60"
ec2_runner_instance_keypair = "runner-ec2-key"
ec2_runner_root_volume_size = 30
ec2_runner_root_volume_type = "gp2"
ec2_runner_data_volume_size = 10
ec2_runner_data_volume_type = "gp2"
ec2_runner_local_user_pwd   = "admin123456;"
ec2_runner_github_pat       = "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"
ec2_runner_github_repo_owner = "GreysonYang-DevOps1"
ec2_runner_github_repo_name  = "github-runner-public"


# VPC Variables
vpc_name                               = "github_runner-vpc"
vpc_cidr_block                         = "10.0.0.0/16"
vpc_public_subnets                     = ["10.0.101.0/24", "10.0.102.0/24"]
vpc_private_subnets                    = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_enable_nat_gateway                 = true
vpc_single_nat_gateway                 = true
vpc_enable_dns_hostnames               = true
vpc_enable_dns_support                 = true