provider "aws" {
  region = "eu-central-1"
}

module "eks-ecr" {
  source = "../"
  repositories = ["test1","test2"]
  ci-user = "test-ci-user"
}

output "ci-user-arn" {
  value = module.eks-ecr.ci-user-arn
}

output "ci-user-id" {
  value = module.eks-ecr.ci-user-id
}

output "ci-user-secret" {
  value = module.eks-ecr.ci-user-secret
}

output "repositories_url" {
  value = module.eks-ecr.repositories_url
}
