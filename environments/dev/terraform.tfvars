# Generic Variables
aws_region       = "ap-southeast-2"
environment      = "dev"
business_divsion = "DevOps1"

# EC2 Variables
instance_name = "Bastion_Host"
instance_type = "t2.small"
ami_id        = "ami-06bb074d1e196d0d4"

# VPC Variables
vpc_name                               = "github_runner-vpc"
vpc_cidr_block                         = "10.0.0.0/16"
vpc_public_subnets                     = ["10.0.101.0/24", "10.0.102.0/24"]
vpc_private_subnets                    = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_enable_nat_gateway                 = true
vpc_single_nat_gateway                 = true
vpc_enable_dns_hostnames               = true
vpc_enable_dns_support                 = true