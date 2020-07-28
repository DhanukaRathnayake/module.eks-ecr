resource "aws_ecr_repository" "repositories" {
  for_each = var.repositories
  name     = var.prefix == "" ? each.value : "${var.prefix}-${each.value}"
}
