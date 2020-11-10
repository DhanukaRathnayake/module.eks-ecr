variable "repositories" {
  description = "List of repositories names."
  type = map(object({
    share       = bool
    accounts_rw = list(string)
    accounts_ro = list(string)
  }))
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

variable "bucket" {
  description = "Custom s3 bucket name."
  type        = string
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

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "share" {
  type    = bool
  default = false
}
