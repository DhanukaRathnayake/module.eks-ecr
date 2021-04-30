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
  repositories = {
    test-1 = {
      share = true,
      // allow read-write access
      accounts_rw = [
        data.aws_caller_identity.current.arn,    // use current identity
        "arn:aws:iam::123456789123:user/hubert", // allow read-write access for single user
      ],
      // allow read-only access
      accounts_ro = [
        "arn:aws:iam::123456789123:user/fry",    // allow read-only access for single user
        "arn:aws:iam::123456789123:user/bender", // allow read-only access for single user
      ]
    },
    test-2 = {
      share = true,
      // allow read-write access
      accounts_rw = [
        "arn:aws:iam::123456789123:group/developers", // allow read-write access for group of users
      ],
      accounts_ro = []
    },
    test-3 = {
      share = true,
      // allow read-write access
      accounts_rw = [
        "arn:aws:iam::456455465665:role/professor", // allow read-write access for role in another account
      ],
      accounts_ro = [
        "arn:aws:iam::456455465665:role/student", // allow read-only access for role in another account
      ]
    },
    test-4 = {
      share       = false, # don't create policy
      accounts_rw = [],
      accounts_ro = []
    }
  }
  prefix              = "test"
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
  value     = module.eks-ecr.ci-user-secret
  sensitive = true
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
