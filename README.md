EKS-ECR MODULE

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | AWS region. | `string` | n/a | yes |
| ci-user | Name of ci-user. | `string` | `"tf-ci-user"` | no |
| prefix | Repository name prefix. | `string` | `""` | no |
| repositories | List of repositories names. | `set(string)` | <pre>[<br>  ""<br>]</pre> | no |
| vpc\_cidr\_block | VPC cidr block whick will be allowed for ecr private link. | `list(string)` | n/a | yes |
| vpc\_id | VPC id. | `string` | n/a | yes |
| vpc\_private\_subnets | List of private subnets. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ci-user-arn | n/a |
| ci-user-id | n/a |
| ci-user-secret | n/a |
| privatelink\_ecr\_api | n/a |
| privatelink\_ecr\_dkr | n/a |
| repositories\_url | n/a |
