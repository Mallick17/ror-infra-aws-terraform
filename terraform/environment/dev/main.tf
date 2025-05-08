terraform {
  backend "s3" {
    bucket = "terraformtf-statetf-buckettf"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "ecr" {
  source = "../../modules/ecr"

  repository_name = var.ecr_repository_name
}

module "ecs_cluster" {
  source = "../../modules/ec2_autoscaling"

  name_prefix           = var.project_prefix
  instance_type         = var.ec2_instance_type
  key_name              = var.key_name
  desired_capacity      = var.asg_desired_capacity
  min_size              = var.asg_min_size
  max_size              = var.asg_max_size
  instance_profile_name = var.ec2_instance_profile_name
  security_group_ids    = var.security_group_ids
  subnet_ids            = var.subnet_ids
}

module "ecs_service" {
  source = "../../modules/ecs_service"

  cluster_id           = module.ecs_cluster.cluster_id
  ecs_service_name     = var.ecs_service_name
  task_family          = var.task_family
  execution_role_arn   = "arn:aws:iam::339713104321:role/ecsTaskExecutionRole"
  app_image            = module.ecr.repository_url
  redis_image          = var.redis_image
  container_port       = var.container_port

  env_rails_env        = var.env_rails_env
  env_db_user          = var.env_db_user
  env_db_password      = var.env_db_password
  env_db_host          = var.env_db_host
  env_db_port          = var.env_db_port
  env_db_name          = var.env_db_name
  env_redis_url        = var.env_redis_url
  env_rails_master_key = var.env_rails_master_key
  env_secret_key_base  = var.env_secret_key_base

  subnet_ids           = var.subnet_ids
  security_group_ids   = var.security_group_ids
  availability_zones   = var.availability_zones
  region               = var.region
}

module "codebuild" {
  source = "../../modules/codebuild"

  project_name              = var.codebuild_project_name
  github_repo_url           = var.github_repo_url
  buildspec_path            = var.buildspec_path
  source_version            = var.source_version
  codebuild_service_role_arn = var.codebuild_service_role_arn
  ecr_repository_url        = module.ecr.repository_url
}

