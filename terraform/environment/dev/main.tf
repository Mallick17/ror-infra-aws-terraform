terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
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

  cluster_name     = module.ecs_cluster.cluster_name
  service_name     = var.ecs_service_name
  task_family      = var.task_family
  container_image  = module.ecr.repository_url
  container_port   = var.container_port
  redis_image      = var.redis_image
  environment_vars = var.environment_vars
  security_group_ids = var.security_group_ids
  subnet_ids          = var.subnet_ids
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

