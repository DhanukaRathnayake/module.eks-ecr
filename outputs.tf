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
  value = values(aws_ecr_repository.repositories)[*]["repository_url"]
}

output "privatelink_ecr_api" {
  value = aws_vpc_endpoint.ecr-api.dns_entry
}

output "privatelink_ecr_dkr" {
  value = aws_vpc_endpoint.ecr-dkr.dns_entry
}
