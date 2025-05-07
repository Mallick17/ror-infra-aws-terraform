variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "Whether image tags are mutable or immutable"
  type        = string
  default     = "MUTABLE"
}

variable "scan_on_push" {
  description = "Whether to scan images on push"
  type        = bool
  default     = true
}
