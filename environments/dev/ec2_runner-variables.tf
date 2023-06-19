# Variables for EC2 GitHub Runner Host

variable "ec2_runner_instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "ec2_runner_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.small"
}

variable "ec2_runner_ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-06bb074d1e196d0d4"
}

variable "ec2_runner_instance_keypair_bucket" {
  description = "Name for S3 bucket where stored AWS EC2 Key Pair"
  type        = string
  default     = "EC2-Key"
}

variable "ec2_runner_instance_keypair" {
  description = "Name for runner EC2 Key Pair"
  type        = string
  default     = "runner-ec2-key"
}

variable "ec2_runner_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Windows Server"
  default     = "30"
}

variable "ec2_runner_data_volume_size" {
  type        = number
  description = "Volumen size of data volumen of Windows Server"
  default     = "10"
}

variable "ec2_runner_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of Windows Server."
  default     = "gp2"
}

variable "ec2_runner_data_volume_type" {
  type        = string
  description = "Volumen type of data volumen of Windows Server."
  default     = "gp2"
}

variable "ec2_runner_local_user_pwd" {
  type        = string
  description = "new password for local user of Windows Server."
}

variable "ec2_runner_version" {
  type        = string
  description = "GitHub Runner Version."
  default     = "2.304.0"
}

variable "ec2_runner_github_api_version" {
  type        = string
  description = "GitHub API Version."
  default     = "2022-11-28"
}

variable "ec2_runner_github_pat" {
  type        = string
  description = "GtiHub Access Token to get Runner Registration Token"
}

variable "ec2_runner_github_repo_owner" {
  type        = string
  description = "GtiHub Repo Owner for Runner Registration"
}

variable "ec2_runner_github_repo_name" {
  type        = string
  description = "GtiHub Repo Name for Runner Registration"
}

variable "ec2_runner_github_repo_registration_token" {
  type        = string
  description = "GtiHub Runner Registration Token"
}