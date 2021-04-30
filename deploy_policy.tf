data "aws_iam_policy_document" "ecr_all_deploy" {
  statement {
    sid    = "ecrecs"
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
