output "ci-user-arn" {
  value = aws_iam_user.ci_deploy_user.arn
}

output "ci-user-id" {
  value = aws_iam_access_key.ci_deploy_user_key.id
}

output "ci-user-secret" {
  value = aws_iam_access_key.ci_deploy_user_key.secret
  sensitive = true
}

output "repositories_url" {
  value = values(aws_ecr_repository.repositories)[*]["repository_url"]
}

output "privatelink_ecr_api" {
  value = length(aws_vpc_endpoint.ecr-api.*.dns_entry) > 0 ? element(concat(aws_vpc_endpoint.ecr-api.*.dns_entry, list("")), 0) : ""
}

output "privatelink_ecr_dkr" {
  value = length(aws_vpc_endpoint.ecr-dkr.*.dns_entry) > 0 ? element(concat(aws_vpc_endpoint.ecr-dkr.*.dns_entry, list("")), 0) : ""
}
