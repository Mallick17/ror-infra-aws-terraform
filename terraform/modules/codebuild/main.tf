resource "aws_codebuild_project" "this" {
  name          = var.project_name
  description   = "CodeBuild project for ECS-deployed Ruby on Rails app"
  build_timeout = 20
  service_role  = var.codebuild_service_role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true

    environment_variable {
      name  = "REPOSITORY_URI"
      value = var.ecr_repository_url
    }
  }

  source {
    type            = "GITHUB"
    location        = var.github_repo_url
    git_clone_depth = 1
    buildspec       = var.buildspec_path
  }

  source_version = var.source_version
}

