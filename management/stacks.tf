module "oci_proposals" {
  source = "../modules/spacelift/stack"

  # This is generic stack setup information. It is not specific to the a proposal stack.
  name        = "oci-proposals"
  description = "oci proposals stack"
  repository_name = "spacelift"
  project_root    = "aws/important-s3-buckets"
  space_id       = spacelift_space.aws.id
  aws_integration = {
    enabled = true
    id      = spacelift_aws_integration.spacelift_io_examples.id
  }


  ## Anything below is required for a proposal stack
  runner_image    = "ghcr.io/spacelift-io-examples/flux-runner-terraform:latest"
  labels = ["proposal-stack"]
  allow_promotion = false
  environment_variables = {
    TF_VAR_env = {
      sensitive = false
      value     = "proposed"
    }
  }

}

module "oci_dev" {
  source = "../modules/spacelift/stack"

  # This is generic stack setup information. It is not specific to the a oci automation stack.
  name        = "oci-dev"
  description = "oci dev stack"
  repository_name = "spacelift"
  project_root    = "aws/important-s3-buckets"
  space_id       = spacelift_space.aws.id
  aws_integration = {
    enabled = true
    id      = spacelift_aws_integration.spacelift_io_examples.id
  }


  ## Anything below is required for an oci automation stack
  runner_image    = "ghcr.io/spacelift-io-examples/flux-runner-terraform:latest"
  environment_variables = {
    TF_VAR_env = {
      sensitive = false
      value     = "dev"
    }
    VERSION = {
      sensitive = false
      value     = local.oci_dev_version
    }
  }
  labels = ["oci-automation"]
}