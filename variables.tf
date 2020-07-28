variable "repositories" {
  description = "List of repositories names."
  type        = set(string)
  default     = [""]
}

variable "ci-user" {
  description = "Name of ci-user."
  type        = string
  default     = "tf-ci-user"
}

variable "prefix" {
  description = "Repository name prefix."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC id."
  type        = string
}

variable "aws_region" {
  description = "AWS region."
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC cidr block whick will be allowed for ecr private link."
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "List of private subnets."
  type        = list(string)
}
