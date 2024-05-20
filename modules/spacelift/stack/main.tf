resource "spacelift_stack" "this" {
  name                    = var.name
  repository              = var.repository_name
  branch                  = var.repository_branch
  description             = var.description
  terraform_version       = var.tofu_version
  worker_pool_id          = var.worker_pool_id
  project_root            = var.project_root
  labels                  = var.labels
  enable_local_preview    = true
  autodeploy              = false
  manage_state            = true
  terraform_workflow_tool = "OPEN_TOFU"
  space_id                = var.space_id
  runner_image            = var.runner_image
  github_action_deploy    = var.allow_promotion

  dynamic "bitbucket_cloud" {
    for_each = var.cloud_integration == "BITBUCKET" ? ["BITBUCKET"] : []

    content {
      namespace = var.bitbucket_cloud_namespace
    }
  }
}

resource "spacelift_aws_integration_attachment" "this" {
  count = var.aws_integration.enabled ? 1 : 0

  integration_id = var.aws_integration.id
  stack_id       = spacelift_stack.this.id
  read           = true
  write          = true
}

resource "spacelift_context_attachment" "this" {
  context_id = spacelift_context.this.id
  stack_id   = spacelift_stack.this.id
}

resource "spacelift_context" "this" {
  description = var.description
  name        = var.name
  space_id    = var.space_id
}

resource "spacelift_environment_variable" "this" {
  for_each = var.environment_variables

  context_id = spacelift_context.this.id
  name       = each.key
  value      = each.value.value
  write_only = each.value.sensitive
}

resource "spacelift_policy" "this" {
  for_each = var.policies

  name = each.key
  body = file(each.value.file_path)
  type = each.value.type

  space_id = var.space_id
}

resource "spacelift_policy_attachment" "this" {
  for_each = var.policies

  policy_id = spacelift_policy.this[each.key].id
  stack_id  = spacelift_stack.this.id
}