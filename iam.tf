resource "aws_iam_user" "ci_deploy_user" {
  name = var.ci-user
  path = "/"
}

resource "aws_iam_access_key" "ci_deploy_user_key" {
  user = aws_iam_user.ci_deploy_user.name
}

resource "aws_iam_user_policy" "ci_deploy_user_policy" {
  name = "ecr-allow-all"
  user = aws_iam_user.ci_deploy_user.name

  policy = data.aws_iam_policy_document.ecr_all_deploy.json
}

resource "aws_ecr_repository_policy" "access_policy" {
  depends_on = [
    aws_ecr_repository.repositories
  ]
  for_each = {
    for k, r in var.repositories : k => r
    if contains(keys(r), "share") && r["share"] == true
  }
  repository = var.prefix == "" ? each.key : "${var.prefix}-${each.key}"
  policy     = data.aws_iam_policy_document.access_policy[each.key].json
}
