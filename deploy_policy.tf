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
  statement {
    sid    = "s3list"
    effect = "Allow"

    resources = [
      "*",
    ]

    actions = [
      "s3:ListBucket",
      "s3:CreateMultipartUpload",
    ]
  }
  statement {
    sid    = "s3write"
    effect = "Allow"

    resources = [
      "${aws_s3_bucket.s3-gitlab-runner-cache.arn}/*"
    ]

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
    ]
  }
}
