variable "repositories" {
  description = "List of repositories names"
  type = list(string)
  default = [""]
}

variable "ci-user" {
  description = "Name of ci-user"
  type = string
  default = "tf-ci-user"
}

variable "prefix" {
  description = "repository name prefix"
  type = string
  default = ""
}
