# AWS Auto Scaling Group with Launch Template for Self Hosted GitHub Runner

data "aws_ami" "windows-2022" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base*"]
  }
}

module "asg_runner" {
  source = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "${local.name}-${var.ec2_runner_asg_name}"

  min_size                  = 0
  max_size                  = 2
  desired_capacity          = 0
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  # vpc_zone_identifier       = module.vpc.public_subnets
  vpc_zone_identifier =  ["subnet-056ae4fa6b5d83e57","subnet-0f8f0d1e16aae1f92"]

  # Launch template
  launch_template_name        = var.ec2_runner_asg_launch_template_name
  launch_template_description = "Launch template for GitHub Runner"
  update_default_version      = true

  image_id      = data.aws_ami.windows-2022.id
  instance_type = var.ec2_runner_instance_type
  key_name      = var.ec2_runner_instance_keypair
  user_data = base64encode(templatefile("${path.module}/templates/githubRunner-windows.tftpl", {
    LOCAL_USER_PWD        = "${var.ec2_runner_local_user_pwd}"
    GITHUB_RUNNER_VERSION = "${var.ec2_runner_version}"
    GITHUB_PAT            = "${var.ec2_runner_github_pat}"
    GITHUB_REPO_OWNER     = "${var.ec2_runner_github_repo_owner}"
    GITHUB_REPO_NAME      = "${var.ec2_runner_github_repo_name}"
    GITHUB_API_VERSION    = "${var.ec2_runner_github_api_version}"
    # GITHUB_REPO_REG_TOKEN = "${var.ec2_runner_github_repo_registration_token}"
    GITHUB_ORGANIZATION   = "${var.ec2_runner_github_organization_name}"
  }))

  enable_monitoring = true

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = var.ec2_runner_root_volume_size
        volume_type           = var.ec2_runner_root_volume_type
      }
      }, {
      device_name = "/dev/sda1"
      no_device   = 1
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = var.ec2_runner_data_volume_size
        volume_type           = var.ec2_runner_data_volume_type
      }
    }
  ]

  network_interfaces = [
    {
      delete_on_termination = true
      associate_public_ip_address = true
      description           = "eth0"
      device_index          = 0
      security_groups       = [module.public_runner_asg_sg.security_group_id]
    }
  ]

  placement = {
    availability_zone = "${var.aws_region}a"
  }

  initial_lifecycle_hooks = [
    {
      name                  = "RunnerTerminationLifeCycleHook"
      default_result        = "CONTINUE"
      heartbeat_timeout     = 180
      lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  tags = local.common_tags

  # Autoscaling Schedule
  schedules = {
    night = {
      min_size         = var.ec2_runner_asg_scaling_schedule_night_min
      max_size         = var.ec2_runner_asg_scaling_schedule_night_max
      desired_capacity = var.ec2_runner_asg_scaling_schedule_night_desired
      recurrence       = var.ec2_runner_asg_scaling_schedule_night_recurrence # Mon-Fri in the evening
      time_zone        = "Australia/Sydney"
    }

    morning = {
      min_size         = var.ec2_runner_asg_scaling_schedule_morning_min
      max_size         = var.ec2_runner_asg_scaling_schedule_morning_max
      desired_capacity = var.ec2_runner_asg_scaling_schedule_morning_desired
      recurrence       = var.ec2_runner_asg_scaling_schedule_morning_recurrence # Mon-Fri in the morning
      time_zone        = "Australia/Sydney"
    }
  }

  # Scaling policy schedule based on average CPU load
  scaling_policies = {
    avg-cpu-policy-greater-than-50 = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = var.ec2_runner_asg_scaling_policy_avg_cpu_warmup
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = var.ec2_runner_asg_scaling_policy_avg_cpu_target_percentage
      }
    }
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
  acl     = "public-read"

  depends_on = [
    module.s3_bucket
  ]
}