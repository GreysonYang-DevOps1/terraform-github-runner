# AWS EC2 Bastion Host

module "ec2_bastion" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "5.1.0"
  name                   = "${local.name}-${var.instance_name}"
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.ec2_bastion_instance_keypair
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  tags                   = local.common_tags
}

resource "aws_key_pair" "terraform_ec2_bastion_public_key" {
  key_name   = var.ec2_bastion_instance_keypair
  public_key = tls_private_key.ec2_bastion-rsa.public_key_openssh
}

resource "tls_private_key" "ec2_bastion-rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_s3_object" "ec2_bastion-key" {
  bucket  = module.s3_bucket.s3_bucket_id
  key     = "${var.instance_keypair_bucket}/${var.ec2_bastion_instance_keypair}"
  content = tls_private_key.ec2_bastion-rsa.private_key_pem
  acl     = "public-read"

  depends_on = [
    module.s3_bucket
  ]
}