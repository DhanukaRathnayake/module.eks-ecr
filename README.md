EKS-ECR MODULE

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ci-user | Name of ci-user | `string` | `"tf-ci-user"` | no |
| prefix | repository name prefix | `string` | `""` | no |
| repositories | List of repositories names | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| ci-user-arn | n/a |
| ci-user-id | n/a |
| ci-user-secret | n/a |
| repositories\_url | n/a |


