# Security Group for EC2 GitHub Runner Host

module "public_runner_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.0.0"

  name        = "${local.name}-public-runner-sg"
  description = "SG - SSH and RDP port open for everybody (IPv4 CIDR)"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["rdp-tcp","rdp-udp"]
  ingress_cidr_blocks = formatlist("%s/32",var.local_machine_ips)
  ingress_with_source_security_group_id = [
    {
      rule = "ssh-tcp"
      source_security_group_id = module.public_bastion_sg.security_group_id
    }
  ]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags         = local.common_tags
}