variable "name" {
  description = "The Google Cloud organization name."
  type        = string
}

variable "environment" {
  type = string
}

variable "organization_id" {
  type = string
}

variable "billing_account" {
  type = string
}

variable "organization_name" {
  type = string
}

variable "gh_org" {
  type = string
}

variable "gh_token" {
  type = string
}

variable "infra_repo_name" {
  type = string
}

variable "tf_org" {
  type = string
}

variable "tf_token" {
  type = string
}
