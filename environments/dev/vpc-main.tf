# # AWS VPC

# # Availability Zones Datasource
# data "aws_availability_zones" "my_azones" {
#   filter {
#     name   = "opt-in-status"
#     values = ["opt-in-not-required"]
#   }
# }

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "5.0.0"

#   # VPC Basic Details
#   name            = "${local.name}-${var.vpc_name}"
#   cidr            = var.vpc_cidr_block
#   azs             = data.aws_availability_zones.my_azones.names
#   public_subnets  = var.vpc_public_subnets
#   private_subnets = var.vpc_private_subnets

#   # Subnets
#   map_public_ip_on_launch = var.vpc_map_public_ip_on_launch

#   # NAT Gateways - Outbound Communication
#   enable_nat_gateway = var.vpc_enable_nat_gateway
#   single_nat_gateway = var.vpc_single_nat_gateway

#   # VPC DNS Parameters
#   enable_dns_hostnames = var.vpc_enable_dns_hostnames
#   enable_dns_support   = var.vpc_enable_dns_support

#   # Tags
#   public_subnet_tags = {
#     Type = "public-subnets"
#   }

#   private_subnet_tags = {
#     Type = "private-subnets"
#   }

#   # Tags for VPC
#   vpc_tags = local.common_tags
#   # Tags for all resources
#   tags = local.common_tags
# }



