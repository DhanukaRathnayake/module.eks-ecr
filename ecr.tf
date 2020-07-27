resource "aws_ecr_repository" "repositories" {
  count = length(var.repositories)
  name = var.prefix == "" ? var.repositories[count.index] : "${var.prefix}-${var.repositories[count.index]}"
}
