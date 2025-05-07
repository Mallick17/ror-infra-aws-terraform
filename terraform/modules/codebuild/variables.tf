variable "project_name" {}
variable "codebuild_service_role_arn" {}
variable "github_repo_url" {}
variable "buildspec_path" {
  default = "buildspec.yml"
}
variable "source_version" {
  default = "main"
}
variable "ecr_repository_url" {}

