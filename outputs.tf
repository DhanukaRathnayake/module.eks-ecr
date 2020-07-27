output "ci-user-arn" {
  value = aws_iam_user.ci_deploy_user.arn
}
output "ci-user-id" {
  value = aws_iam_access_key.ci_deploy_user_key.id
}

output "ci-user-secret" {
  value = aws_iam_access_key.ci_deploy_user_key.secret
}

output "repositories_url" {
  value = aws_ecr_repository.repositories.*.repository_url
}
