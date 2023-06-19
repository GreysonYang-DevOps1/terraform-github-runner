# Security Group for Public Bastion Host

module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.0.0"

  name        = "${local.name}-public-bastion-sg"
  description = "SG - SSH port open for everybody (IPv4 CIDR)"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = formatlist("%s/32", var.local_machine_ips)
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags         = local.common_tags
}