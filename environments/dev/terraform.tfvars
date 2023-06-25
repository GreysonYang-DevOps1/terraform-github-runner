# Generic Variables
aws_region       = "ap-southeast-2"
environment      = "dev"
business_divsion = "DevOps1"

# EC2 Bastion Host Variables
instance_name                = "Bastion_Host"
instance_type                = "t2.small"
ami_id                       = "ami-06bb074d1e196d0d4"
ec2_bastion_instance_keypair = "bastion-ec2-key"

# EC2 GitHub Runner Variables
ec2_runner_instance_name    = "EC2-Self-Hosted-Runner-Windows"
ec2_runner_instance_type    = "t2.medium"
ec2_runner_ami_id           = "ami-05edfd48928db6e60"
ec2_runner_instance_keypair = "runner-ec2-key"
ec2_runner_root_volume_size = 30
ec2_runner_root_volume_type = "gp2"
ec2_runner_data_volume_size = 30
ec2_runner_data_volume_type = "gp2"

# EC2 GitHub Runner ASG Variables
ec2_runner_asg_name                                     = "GitHub-Runner-ASG"
ec2_runner_asg_launch_template_name                     = "GitHub-Runner-LT"
ec2_runner_asg_scaling_schedule_night_recurrence        = "0 18 * * 1-5"
ec2_runner_asg_scaling_schedule_night_min               = 0
ec2_runner_asg_scaling_schedule_night_max               = 0
ec2_runner_asg_scaling_schedule_night_desired           = 0
ec2_runner_asg_scaling_schedule_morning_recurrence      = "0 7 * * 1-5"
ec2_runner_asg_scaling_schedule_morning_min             = 0
ec2_runner_asg_scaling_schedule_morning_max             = 2
ec2_runner_asg_scaling_schedule_morning_desired         = 1
ec2_runner_asg_scaling_policy_avg_cpu_warmup            = 600
ec2_runner_asg_scaling_policy_avg_cpu_target_percentage = 50.0

# VPC Variables
# vpc_name                 = "github_runner-vpc"
# vpc_cidr_block           = "10.0.0.0/16"
# vpc_public_subnets       = ["10.0.101.0/24", "10.0.102.0/24"]
# vpc_private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
# vpc_enable_nat_gateway   = true
# vpc_single_nat_gateway   = true
# vpc_enable_dns_hostnames = true
# vpc_enable_dns_support   = true
# vpc_map_public_ip_on_launch = false