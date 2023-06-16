# Variables for GitHub Runner Auto Scaling Group

variable "ec2_runner_asg_name" {
  type        = string
  description = "GtiHub Runner Auto Scaling Group Name"
  default     = "GitHub-Runner-ASG"
}

variable "ec2_runner_asg_launch_template_name" {
  type        = string
  description = "GtiHub Runner Launch Template Name"
  default     = "GitHub-Runner-LT"
}

variable "ec2_runner_asg_scaling_policy_avg_cpu_target_percentage" {
  type        = number
  description = "Target CPU Percentage for Scaling Policy"
  default     = 50.0
}

variable "ec2_runner_asg_scaling_policy_avg_cpu_warmup" {
  type        = number
  description = "Instance Warmup Time for Scaling Policy"
  default     = 600
}

variable "ec2_runner_asg_scaling_schedule_night_min" {
  type        = number
  description = "Minium Numer Of Instance During The Night"
  default     = 1
}

variable "ec2_runner_asg_scaling_schedule_night_max" {
  type        = number
  description = "Maxium Numer Of Instance During The Night"
  default     = 1
}

variable "ec2_runner_asg_scaling_schedule_night_desired" {
  type        = number
  description = "Desired Numer Of Instance During The Night"
  default     = 1
}

variable "ec2_runner_asg_scaling_schedule_morning_min" {
  type        = number
  description = "Minium Numer Of Instance During The Morning"
  default     = 3
}

variable "ec2_runner_asg_scaling_schedule_morning_max" {
  type        = number
  description = "Maxium Numer Of Instance During The Morning"
  default     = 5
}

variable "ec2_runner_asg_scaling_schedule_morning_desired" {
  type        = number
  description = "Desired Numer Of Instance During The Morning"
  default     = 3
}

variable "ec2_runner_asg_scaling_schedule_night_recurrence" {
  type        = string
  description = "Auto Scaling Schedule for Night"
  default     = "0 18 * * 1-5"
}

variable "ec2_runner_asg_scaling_schedule_morning_recurrence" {
  type        = string
  description = "Auto Scaling Schedule for Morning"
  default     = "0 7 * * 1-5"
}