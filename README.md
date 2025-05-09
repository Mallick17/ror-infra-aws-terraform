# Terraform Infrastructure Documentation for Ruby on Rails App on AWS (ECS EC2 Launch Type)

## 📁 Project Structure

```
terraform/
├── environment
│   └── dev
│       ├── main.tf
│       ├── terraform.tfvars
│       └── variables.tf
└── modules
    ├── codebuild
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── ec2_autoscaling
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── ecr
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    └── ecs_service
        ├── main.tf
        ├── outputs.tf
        ├── task_definition.tf
        └── variables.tf
```

---

## Overview

This infrastructure provisions and deploys a Ruby on Rails application to an **ECS cluster (EC2 Launch Type)** using a modularized **Terraform** setup. Components include:
- Elastic Container Registry (ECR)
- ECS Cluster with Auto Scaling EC2 instances
- ECS Service with App and Redis containers
- AWS CodeBuild to build Docker images

---

## 📦 Module Breakdown

### 1. `ecr/`
Creates an ECR repository to store the Docker image for the Rails app.
- **Purpose**: Store Docker image to be used in ECS Task.
- **Key Variable**: `repository_name`
- **Output**: `repository_url`

### 2. `ec2_autoscaling/`
Sets up:
- ECS cluster
- Launch Template using ECS-optimized Amazon Linux 2 AMI
- Auto Scaling Group
- ECS Capacity Provider

- **Purpose**: Provides the compute layer for ECS using EC2.
- **Inputs**:
  - `name_prefix`, `instance_type`, `key_name`, `instance_profile_name`
  - `desired_capacity`, `min_size`, `max_size`
  - `subnet_ids`, `security_group_ids`

- **Key Resources**:
  - `aws_ecs_cluster`
  - `aws_launch_template`
  - `aws_autoscaling_group`
  - `aws_ecs_capacity_provider`

### 3. `ecs_service/`
Defines ECS Task Definition and Service.

- **Purpose**: Deploys Rails app and Redis as containers.

- **Inputs**:
  - `cluster_id`, `execution_role_arn`, `app_image`, `redis_image`
  - Environment variables (Rails/DB/Redis)
  - Networking (subnets, security groups)

- **Files**:
  - `main.tf`: ECS Service and Load Balancer if needed
  - `task_definition.tf`: Multi-container task definition (Rails + Redis)

### 4. `codebuild/`
Defines CodeBuild project to build Docker image from GitHub source.
- **Purpose**: Automates Docker image build and pushes to ECR.
- **Inputs**:
  - `project_name`, `github_repo_url`, `buildspec_path`, `source_version`
  - `codebuild_service_role_arn`, `ecr_repository_url`

- **Extras**:
  - Includes a `null_resource` to trigger build using AWS CLI:

    ```hcl
    resource "null_resource" "trigger_codebuild_build" {
      triggers = {
        always_run = timestamp()
      }

      provisioner "local-exec" {
        command = "aws codebuild start-build --project-name ${aws_codebuild_project.this.name}"
      }

      depends_on = [aws_codebuild_project.this]
    }
    ```

---

## 📂 Environment Configuration (`environment/dev`)

### `main.tf`
Calls all the above modules, wiring them with the required variables.

### `terraform.tfvars`
Stores variable values specific to the `dev` environment, e.g.:

```hcl
project_prefix           = "ror"
ec2_instance_type        = "t3.medium"
key_name                 = "Myops"
instance_profile_name    = "ecsInstanceRole"
asg_desired_capacity     = 1
asg_min_size             = 1
asg_max_size             = 2
security_group_ids       = ["sg-0106a2994ff8e49aa"]
subnet_ids               = ["subnet-xxxxxx"]
availability_zones       = ["ap-south-1a", "ap-south-1b"]
ecr_repository_name      = "ror-app-repo"
ecs_service_name         = "ror-service"
task_family              = "ror-task"
redis_image              = "redis:7"
container_port           = 3000
# Rails & DB ENV variables
env_rails_env            = "production"
env_db_user              = "postgres"
env_db_password          = "password"
env_db_host              = "db-host"
env_db_port              = "5432"
env_db_name              = "ror_db"
env_redis_url            = "redis://localhost:6379"
env_rails_master_key     = "your_master_key"
env_secret_key_base      = "your_secret_key"
# CodeBuild
codebuild_project_name   = "ror-codebuild"
github_repo_url          = "https://github.com/your/repo"
buildspec_path           = "buildspec.yml"
source_version           = "main"
codebuild_service_role_arn = "arn:aws:iam::123456789012:role/codebuild-service-role"
region                   = "ap-south-1"
```

### `variables.tf`
Declares all variables used in `main.tf`

---

## 🚀 Deployment Steps

1. **Initialize Terraform**:

   ```sh
   terraform init
   ```
2. **Review plan**:

   ```sh
   terraform plan
   ```
3. **Apply changes**:

   ```sh
   terraform apply
   ```
4. **Image build via CodeBuild**:
   - Automatically triggered if `null_resource` is used.
   - Otherwise, trigger manually:

     ```sh
     aws codebuild start-build --project-name ror-codebuild --region ap-south-1
     ```

---

## Future Enhancements
- Add CodePipeline for full CI/CD.
- Attach Load Balancer (ALB) for production traffic.
- Add RDS and ElasticCache via Terraform for production-ready setup.

---

## Notes
- ECS EC2 launch type requires manual instance provisioning via ASG.
- Make sure `ecsInstanceRole` is correctly attached as an **instance profile**, not just an IAM role.
- CodeBuild must have permissions to push to ECR.
- All modules are reusable for multiple environments (e.g., staging, prod) by creating separate folders under `environment/`.

---
