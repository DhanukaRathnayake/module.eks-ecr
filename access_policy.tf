data "aws_iam_policy_document" "access_policy" {

  for_each = {
    for k, r in var.repositories : k => r
    if contains(keys(r), "share") && r.share == true
  }

  source_json = data.aws_iam_policy_document.access_policy_ro[each.key].json

  statement {
    sid    = "allow-another-accounts-rw-access"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = each.value["accounts_rw"]
    }
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
      "ecs:DeregisterTaskDefinition",
      "ecr:GetDownloadUrlForLayer"
    ]
  }
}

data "aws_iam_policy_document" "access_policy_ro" {

  for_each = {
    for k, r in var.repositories : k => r
    if contains(keys(r), "share") && r.share == true
  }
  statement {
    sid    = "allow-another-accounts-ro-access"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = each.value["accounts_ro"]
    }
    actions = [
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer"
    ]
  }
}
