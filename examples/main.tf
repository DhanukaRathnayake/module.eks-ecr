provider "aws" {
  region = "eu-central-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

module "eks-ecr" {
  source = "../"
  repositories = { test-1 = { share = true, accounts = ["arn:aws:iam::691961290356:root", "arn:aws:iam::120826591627:root"] },
    test-2 = { share = false, accounts = ["arn:aws:iam::691961290356:root"] } # this will not create repository policy
  }
  ci-user             = "test-ci-user"
  aws_region          = "eu-central-1"
  vpc_id              = data.aws_vpc.default.id
  vpc_cidr_block      = [data.aws_vpc.default.cidr_block]
  vpc_private_subnets = [tolist(data.aws_subnet_ids.all.ids)[0]]
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

output "privatelink_ecr_api" {
  value = module.eks-ecr.privatelink_ecr_api
}

output "privatelink_ecr_dkr" {
  value = module.eks-ecr.privatelink_ecr_dkr
}
