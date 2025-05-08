# --- Network ---
security_group_ids = [
  "sg-0a35e9086b143cac5",
  "sg-0106a2994ff8e49aa"
]

subnet_ids = [
  "subnet-03b17848527227137",
  "subnet-04cf194b656ad564e",
  "subnet-0738b2e70f37fe442"
]

availability_zones = [
  "ap-south-1a",
  "ap-south-1b",
  "ap-south-1c"
]

region = "ap-south-1"

# --- Project Prefix ---
project_prefix = "final-ror"

# --- EC2 Auto Scaling Group ---
asg_desired_capacity      = 1
asg_min_size              = 1
asg_max_size              = 3
ec2_instance_type         = "t3.medium"
key_name                  = "Myops"  # <- REPLACE THIS
ec2_instance_profile_name = "ecsInstanceProfile"

# --- ECR ---
ecr_repository_name = "final-ror-ecr"

# --- ECS Service & Task Definition ---
ecs_service_name  = "final-ror-cluster-service"
task_family       = "final-ror-task-definition"
container_port    = 80
container_image   = "339713104321.dkr.ecr.ap-south-1.amazonaws.com/final-ror-ecr:latest"
redis_image       = "redis:7"

# --- Environment Variables for Rails App ---
env_rails_env        = "production"
env_db_user          = "myuser"
env_db_password      = "mypassword"
env_db_host          = "rorchatapp.c342ea4cs6ny.ap-south-1.rds.amazonaws.com"
env_db_port          = "5432"
env_db_name          = "rorchatapp"
env_redis_url        = "redis://redis:6379/0"
env_rails_master_key = "c3ca922688d4bf22ac7fe38430dd8849"
env_secret_key_base  = "600f21de02355f788c759ff862a2cb22ba84ccbf072487992f4c2c49ae260f87c7593a1f5f6cf2e45457c76994779a8b30014ee9597e35a2818ca91e33bb7233"

# --- CodeBuild ---
codebuild_project_name        = "ror-codebuild"
github_repo_url               = "https://github.com/Mallick17/ROR-AWS-ECS.git"
buildspec_path                = "buildspec.yml"
source_version                = "master"
codebuild_service_role_arn    = "arn:aws:iam::339713104321:role/codebuild-ror-app-role"


environment_vars = {
  RAILS_ENV     = "production"
  DATABASE_URL  = "postgres://myuser:mypassword@rorchatapp.c342ea4cs6ny.ap-south-1.rds.amazonaws.com:5432/rorchatapp"
  REDIS_URL     = "redis://localhost:6379/0"
  SECRET_KEY_BASE = "600f21de02355f788c759ff862a2cb22ba84ccbf072487992f4c2c49ae260f87c7593a1f5f6cf2e45457c76994779a8b30014ee9597e35a2818ca91e33bb7233"
}

