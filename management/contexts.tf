resource "spacelift_context" "oci" {
  name   = "oci-automation"
  labels = ["autoattach:oci-automation"]

  before_init = [
    "echo $GHCR_TOKEN | docker login ghcr.io -u spacelift-io-examples --password-stdin",
    "flux pull artifact oci://ghcr.io/spacelift-io-examples/oci-repository-example:$VERSION --output $PWD",
  ]

  after_apply = [
    "echo $GHCR_TOKEN | docker login ghcr.io -u spacelift-io-examples --password-stdin",
    "flux tag artifact oci://ghcr.io/spacelift-io-examples/oci-repository-example:$VERSION --tag staging.$VERSION"
  ]

  space_id = spacelift_space.aws.id
}

# resource "spacelift_environment_variable" "oci_ghcr_token" {
#   context_id = spacelift_context.oci.id
#   name       = "GHCR_TOKEN"
#   value      = "applied manually to context"
# }