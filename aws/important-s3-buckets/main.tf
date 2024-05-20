variable "env" {
  type        = string
  description = "The environment name"
}

resource "aws_s3_bucket" "this" {
  bucket = "important-s3-${var.env}-ab98bdha9bha9s57b-example"
}