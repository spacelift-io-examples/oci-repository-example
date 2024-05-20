resource "spacelift_space" "aws" {
  name             = "aws"
  parent_space_id  = "root"
  description      = "Space for AWS accounts"
  inherit_entities = true
}