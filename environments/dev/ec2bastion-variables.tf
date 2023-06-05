# Variables for EC2 Bastion Host

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.small"
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-06bb074d1e196d0d4"
}

variable "instance_keypair_bucket" {
  description = "Name for S3 bucket where stored AWS EC2 Key Pair"
  type        = string
  default     = "EC2-Key"
}

variable "ec2_bastion_instance_keypair" {
  description = "Name for Bastion EC2 Key Pair"
  type        = string
  default     = "bastion-ec2-key"
}

variable "local_machine_ips" {
  description = "Use for adding your local IP address into SG"
  type        = list(string)
  default     = ["10.0.0.0"]
}