variable "name_prefix" {
  description = "Prefix for naming ECS cluster and related resources"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Max size of ASG"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Min size of ASG"
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "Subnets to launch EC2 instances in"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs to attach to EC2 instances"
  type        = list(string)
}
