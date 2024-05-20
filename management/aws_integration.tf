resource "spacelift_aws_integration" "spacelift_io_examples" {
  name     = "spacelift-io-examples"
  role_arn = "arn:aws:iam::your_account_id:role/spacelift"

  space_id = "root"
}
