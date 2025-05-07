variable "cluster_id" {}
variable "service_name" {}
variable "task_family" {}
variable "execution_role_arn" {}
variable "task_cpu" {
  default = "2048"
}
variable "task_memory" {
  default = "3072"
}
variable "desired_count" {
  default = 1
}
variable "region" {}

variable "app_image" {}
variable "redis_image" {}

variable "env_rails_env" {}
variable "env_db_user" {}
variable "env_db_password" {}
variable "env_db_host" {}
variable "env_db_port" {}
variable "env_db_name" {}
variable "env_redis_url" {}
variable "env_rails_master_key" {}
variable "env_secret_key_base" {}

variable "availability_zones" {
  type = list(string)
}

