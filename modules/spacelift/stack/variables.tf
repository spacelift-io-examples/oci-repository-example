variable "name" {
  type        = string
  description = "REQUIRED The name of the Spacelift stack to create."
}

variable "cloud_integration" {
  type        = string
  description = "The cloud integration to use for the stack. BITBUCKET or GITHUB."
  default     = "GITHUB"

  validation {
    condition     = var.cloud_integration == "BITBUCKET" || var.cloud_integration == "GITHUB"
    error_message = "The cloud integration must be either BITBUCKET or GITHUB."
  }
}

variable "bitbucket_cloud_namespace" {
  type        = string
  description = "The namespace of the Bitbucket Cloud account to use for the stack. Required if cloud_integration is BITBUCKET."
  default     = null
}

variable "repository_name" {
  type        = string
  description = "REQUIRED The name of the Git repository for the stack to use."
}

variable "description" {
  type        = string
  description = "REQUIRED A description to describe your Spacelift stack."
}

variable "space_id" {
  type        = string
  description = "REQUIRED The ID of the space this stack will be in."
}

variable "repository_branch" {
  type        = string
  description = "The name of the branch to use for the specified Git repository."
  default     = "main"
}

variable "tofu_version" {
  type        = string
  description = "The version of OpenTofu for your stack to use. Defaults to latest."
  default     = "1.7.1"
}

variable "project_root" {
  type        = string
  description = "The path to your project root in your repository to use as the root of the stack. Defaults to root of the repository."
  default     = null
}

variable "labels" {
  type        = list(string)
  description = "Labels to apply to the stack being created."
  default     = []
}

variable "worker_pool_id" {
  type        = string
  description = "The ID of the worker pool to use for Spacelift stack runs. Defaults to public worker pool."
  default     = null
}

variable "aws_integration" {
  type = object({
    enabled = bool
    id      = optional(string)
  })
  description = "Spacelift AWS integration configuration"

  default = {
    enabled = false
  }

  validation {
    condition     = var.aws_integration.enabled == false || (var.aws_integration.enabled && var.aws_integration.id != null)
    error_message = "The integration id must be included if aws_entegration is enabled."
  }
}

variable "environment_variables" {
  type = map(object({
    value     = string
    sensitive = bool
  }))
  description = "Environment variables to add to the context."
  default     = {}
}

variable "policies" {
  type = map(object({
    file_path = string
    type      = string
  }))
  description = "Policies to add to the stack."
  default     = {}
}

variable "runner_image" {
  type        = string
  description = "The runner image to use for the stack. Defaults to the latest version."
  default     = null
}

variable "allow_promotion" {
  type        = bool
  description = "Whether to allow promotion of the stack to the next environment."
  default     = true
}