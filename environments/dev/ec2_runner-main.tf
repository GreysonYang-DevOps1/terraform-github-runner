# AWS EC2 GitHub Runner Host

data "aws_ami" "windows-2022" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base*"]
  }
}

module "ec2_runner" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "5.1.0"
  name                   = "${local.name}-${var.ec2_runner_instance_name}"
  ami                    = data.aws_ami.windows-2022.id
  instance_type          = var.ec2_runner_instance_type
  key_name               = var.ec2_runner_instance_keypair
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.public_runner_sg.security_group_id]
  get_password_data      = true
  tags                   = local.common_tags
  user_data              = data.template_file.windows-userdata.rendered

  root_block_device = [
    {
      volume_size           = var.ec2_runner_root_volume_size
      volume_type           = var.ec2_runner_root_volume_type
      delete_on_termination = true
      encrypted             = true
    }
  ]

  ebs_block_device = [
    {
      device_name           = "/dev/xvda"
      volume_size           = var.ec2_runner_data_volume_size
      volume_type           = var.ec2_runner_data_volume_type
      encrypted             = true
      delete_on_termination = true
    }
  ]
}

data "template_file" "windows-userdata" {
  template = "${file("${path.module}/templates/githubRunner-windows.tftpl")}"
  vars = {
    LOCAL_USER_PWD = "${var.ec2_runner_local_user_pwd}"
    GITHUB_RUNNER_VERSION = "${var.ec2_runner_version}"
    GITHUB_PAT = "${var.ec2_runner_github_pat}"
    GITHUB_REPO_OWNER = "${var.ec2_runner_github_repo_owner}"
    GITHUB_REPO_NAME = "${var.ec2_runner_github_repo_name}"
    GITHUB_API_VERSION = "${var.ec2_runner_github_api_version}"
  }
}

resource "aws_key_pair" "terraform_ec2_runner_public_key" {
  key_name   = var.ec2_runner_instance_keypair
  public_key = tls_private_key.ec2_runner-rsa.public_key_openssh
}

resource "tls_private_key" "ec2_runner-rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_s3_object" "ec2_runner-key" {
  bucket  = module.s3_bucket.s3_bucket_id
  key     = "${var.instance_keypair_bucket}/${var.ec2_runner_instance_keypair}"
  content = tls_private_key.ec2_runner-rsa.private_key_pem
  acl = "public-read"

  depends_on = [
    module.s3_bucket
  ]
}