# General
project_prefix = "final-ror"

# EC2 Auto Scaling
ec2_instance_type         = "t3.micro"
key_name                  = "your-keypair-name"
asg_desired_capacity      = 1
asg_min_size              = 1
asg_max_size              = 2
ec2_instance_profile_name = "ecsInstanceRole"

security_group_ids = [
  "sg-0a35e9086b143cac5",
  "sg-0106a2994ff8e49aa"
]

subnet_ids = [
  "subnet-03b17848527227137",
  "subnet-04cf194b656ad564e",
  "subnet-0738b2e70f37fe442"
]

# ECR
ecr_repository_name = "mallow-ror-app"

# ECS Service and Task Definition
ecs_service_name  = "final-ror-cluster-service"
task_family       = "final-ror-task-definition"
container_port    = 80
redis_image       = "redis:7"

environment_vars = {
  RAILS_ENV         = "production"
  DB_USER           = "myuser"
  DB_PASSWORD       = "mypassword"
  DB_HOST           = "rorchatapp.c342ea4cs6ny.ap-south-1.rds.amazonaws.com"
  DB_PORT           = "5432"
  DB_NAME           = "rorchatapp"
  REDIS_URL         = "redis://redis:6379/0"
  RAILS_MASTER_KEY  = "c3ca922688d4bf22ac7fe38430dd8849"
  SECRET_KEY_BASE   = "600f21de02355f788c759ff862a2cb22ba84ccbf072487992f4c2c49ae260f87c7593a1f5f6cf2e45457c76994779a8b30014ee9597e35a2818ca91e33bb7233"
}

# CodeBuild
codebuild_project_name       = "ror-codebuild"
github_repo_url              = "https://github.com/your-org/your-ror-repo.git"
buildspec_path               = "buildspec.yml"
source_version               = "main"
codebuild_service_role_arn   = "arn:aws:iam::YOUR_ACCOUNT_ID:role/codebuild-service-role"

