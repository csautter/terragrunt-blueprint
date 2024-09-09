resource "random_string" "dummy" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "dummy" {
  bucket = "dummy-${random_string.dummy.result}"
}