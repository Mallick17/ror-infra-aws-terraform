# General
variable "project_prefix" {
  description = "Prefix for all resources"
  type        = string
}

# EC2 Auto Scaling
variable "ec2_instance_type" {
  description = "EC2 instance type for ECS"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}

variable "asg_desired_capacity" {
  description = "Desired capacity for Auto Scaling Group"
  type        = number
}

variable "asg_min_size" {
  description = "Minimum size for Auto Scaling Group"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum size for Auto Scaling Group"
  type        = number
}

variable "ec2_instance_profile_name" {
  description = "Name of the instance profile attached to ECS EC2 instances"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs for ECS EC2 and service networking"
  type        = list(string)
}

variable "subnet_ids" {
  description = "Subnet IDs for ECS and ASG"
  type        = list(string)
}

# ECR
variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
}

# ECS Service and Task Definition
variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "task_family" {
  description = "Task definition family name"
  type        = string
}

variable "container_image" {
  description = "App container image URI (ECR)"
  type        = string
}

variable "container_port" {
  description = "Port on which the app container listens"
  type        = number
}

variable "redis_image" {
  description = "Redis container image"
  type        = string
}

variable "environment_vars" {
  description = "Environment variables for the app container"
  type        = map(string)
}

# CodeBuild
variable "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  type        = string
}

variable "github_repo_url" {
  description = "GitHub repository URL"
  type        = string
}

variable "buildspec_path" {
  description = "Path to buildspec file in the repository"
  type        = string
}

variable "source_version" {
  description = "Branch or tag to build"
  type        = string
}

variable "codebuild_service_role_arn" {
  description = "IAM Role ARN for CodeBuild"
  type        = string
}

