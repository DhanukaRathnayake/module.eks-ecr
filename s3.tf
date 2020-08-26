resource "aws_s3_bucket" "s3-gitlab-runner-cache" {
  bucket = var.prefix == "" ? "s3-gitlab-runner-cache" : "${var.prefix}-s3-gitlab-runner-cache"
  acl    = "private"
  versioning {
    enabled = false
  }

  tags = {
    Name = var.prefix == "" ? "s3-gitlab-runner-cache" : "${var.prefix}-s3-gitlab-runner-cache"
  }
}