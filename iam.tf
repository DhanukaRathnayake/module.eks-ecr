resource "aws_iam_user" "ci_deploy_user" {
  name = var.ci-user
  path = "/"
}

resource "aws_iam_user_policy" "ci_deploy_user_policy" {
  name = "ecr-allow-all"
  user = aws_iam_user.ci_deploy_user.name

  policy = data.aws_iam_policy_document.ecr_all_deploy.json
}

resource "aws_iam_access_key" "ci_deploy_user_key" {
  user = aws_iam_user.ci_deploy_user.name
}

data "aws_iam_policy_document" "ecr_all_deploy" {
  statement {
    effect = "Allow"

    resources = [
      "*",
    ]

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:GetLifecyclePolicy",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:ListTagsForResource",
      "ecr:DescribeImageScanFindings",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
      "ecs:List*",
      "ecs:Describe*",
      "ecs:CreateService",
      "ecs:RegisterTaskDefinition",
      "iam:PassRole",
      "ecs:UpdateService",
      "ecs:DeregisterTaskDefinition"
    ]
  }
}

data "aws_iam_policy_document" "another-accounts-access" {
  for_each = {
    for k, r in var.repositories : k => r
    if contains(keys(r), "share") && r["share"] == true
  }
  statement {
    sid    = "allow-another-accounts-access"
    effect = "Allow"
    principals {
      identifiers = each.value["accounts"]
      type        = "AWS"
    }
    actions = [
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer"
    ]

  }
}


resource "aws_ecr_repository_policy" "another-accounts-access" {
  for_each = {
    for k, r in var.repositories : k => r
    if contains(keys(r), "share") && r["share"] == true
  }
  repository = var.prefix == "" ? each.key : "${var.prefix}-${each.key}"
  policy     = data.aws_iam_policy_document.another-accounts-access[each.key].json
}





