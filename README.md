# EKS-ECR module

## Example

For more complex code sample please see the [examples](examples).

```hcl-terraform
module "eks-ecr" {
  source = "../"
  prefix              = "test" 
  ci-user             = "test-ci-user"
  aws_region          = "eu-central-1"
  vpc_id              = data.aws_vpc.default.id
  vpc_cidr_block      = [data.aws_vpc.default.cidr_block]
  vpc_private_subnets = [tolist(data.aws_subnet_ids.all.ids)[0]]
  repositories = {
    test-1 = {
      share = true, // create access policies
      accounts_rw = [
        "arn:aws:iam::123456789123:user/hubert", // allow read-write access for single user
      ],
      accounts_ro = [
        "arn:aws:iam::123456789123:user/fry",     // allow read-only access for single user
      ]
    }
  }
  
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | AWS region. | `string` | n/a | yes |
| ci-user | Name of ci-user. | `string` | `"tf-ci-user"` | no |
| vpc\_cidr\_block | VPC cidr block whick will be allowed for ecr private link. | `list(string)` | n/a | yes |
| vpc\_id | VPC id. | `string` | n/a | yes |
| vpc\_private\_subnets | List of private subnets. | `list(string)` | n/a | yes |
| prefix | Repository name prefix. | `string` | `""` | no |
| share | n/a | `bool` | `false` | no |
| repositories | Map of repositories and their read-write access accounts/groups/users/roles. | <pre>map(object({<br>    share    = bool<br>    accounts_rw = list(string)<br>    accounts_ro = list(string)<br>  }))</pre> | n/a | yes |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| ci-user-arn | n/a |
| ci-user-id | n/a |
| ci-user-secret | n/a |
| privatelink\_ecr\_api | n/a |
| privatelink\_ecr\_dkr | n/a |
| repositories\_url | n/a |
