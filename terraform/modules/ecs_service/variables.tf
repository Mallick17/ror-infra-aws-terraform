variable "cluster_id" {
  description = "ECS Cluster ID to associate the service with"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "task_family" {
  description = "Task definition family name"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM role ARN for ECS task execution"
  type        = string
}

variable "task_cpu" {
  description = "CPU units used by the task"
  type        = string
  default     = "2048"
}

variable "task_memory" {
  description = "Memory used by the task (in MiB)"
  type        = string
  default     = "3072"
}

variable "container_port" {
  description = "Port the app container listens on"
  type        = number
  default     = 80
}

variable "desired_count" {
  description = "Number of tasks to run"
  type        = number
  default     = 1
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "app_image" {
  description = "Docker image URL for the Rails app"
  type        = string
}

variable "redis_image" {
  description = "Docker image for Redis sidecar"
  type        = string
}

# Environment variables
variable "env_rails_env" {
  type        = string
  description = "Rails environment (e.g., production)"
}

variable "env_db_user" {
  type        = string
  description = "Database username"
}

variable "env_db_password" {
  type        = string
  description = "Database password"
}

variable "env_db_host" {
  type        = string
  description = "Database host"
}

variable "env_db_port" {
  type        = string
  description = "Database port"
}

variable "env_db_name" {
  type        = string
  description = "Database name"
}

variable "env_redis_url" {
  type        = string
  description = "Redis URL for sidecar"
}

variable "env_rails_master_key" {
  type        = string
  description = "Rails master key for secrets decryption"
}

variable "env_secret_key_base" {
  type        = string
  description = "Rails secret key base"
}

# Network
variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to launch the ECS service in"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security groups for the ECS service"
}

