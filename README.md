# EKS-ECR module

## Usage

Remember that your users should be equipped with at least `ReadOnlyAccess` or something similar in order
to successfully access the ECR using a command line for example:

    aws ecr get-login-password --region us-mars-1 | docker login --username AWS --password-stdin ABCDEFGHIJKL.dkr.ecr.eu-central-1.amazonaws.com

will fail when you try to do that with an "empty" user (with no permissions) altough you are allowing the access here per a repository:

```hcl-terraform
module "eks-ecr" {
  source = "../"
  prefix              = "test"
  bucket              = "my-bucket-name"
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

For more detailed example please see the [examples](examples) directory. For more information on how to setup IAM group permissions please see https://gitlab.lukapo.com/terraform/aws/module.iam-base/-/blob/master/README.md

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | AWS region. | `string` | n/a | yes |
| ci-user | Name of ci-user. | `string` | `"tf-ci-user"` | no |
| connect\_vpc | Switch on/of the privatelink VPC connection | `bool` | false | no |
| vpc\_cidr\_block | VPC cidr block whick will be allowed for ecr private link. | `list(string)` | `[]`| no |
| vpc\_id | VPC id. | `string` | `""` | no |
| vpc\_private\_subnets | List of private subnets. | `list(string)` | `[]` | no |
| prefix | Repository name prefix. | `string` | `""` | no |
| bucket | Custom S3 bucket name. | `string` | n/a | yes |
| share | n/a | `bool` | `false` | no |
| repositories | Map of repositories and their read-write access accounts/groups/users/roles. | <pre>map(object({<br>    share    = bool<br>    accounts_rw = list(string)<br>    accounts_ro = list(string)<br>  }))</pre> | n/a | yes |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| ci-user-arn | n/a |
| bucket | Bucket name |
| bucket-arn | Bucket ARN |
| ci-user-id | n/a |
| ci-user-secret | n/a |
| privatelink\_ecr\_api | n/a |
| privatelink\_ecr\_dkr | n/a |
| repositories\_url | n/a |
