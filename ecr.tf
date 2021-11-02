resource "aws_ecr_repository" "repositories" {
  for_each = var.repositories

  name = var.prefix == "" ? each.key : "${var.prefix}-${each.key}"

  image_tag_mutability = var.tag_mutability
}
