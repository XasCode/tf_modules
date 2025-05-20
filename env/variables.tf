variable "name" {
  description = "Environment name."
  type        = string
}

variable "parent" {
  description = "Path and name identifier for the parent of this env."
  type = object({
    path = string
    name = string
  })
}

variable "envs" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "gh_org" {
  type = string
}

variable "gh_token" {
  type = string
}

variable "tf_org" {
  type = string
}

variable "tf_token" {
  type = string
}

variable "infra_repo_name" {
  type = string
}

variable "infra_repo_org" {
  type = string
}

variable "billing_account" {
  type = string
}

variable "organization_name" {
  type = string
}

variable "organization_id" {
  type = string
}

variable "sg" {
  type = string
}

variable "build" {
  type = string
}

variable "projects" {
  type = object({
    sa   = object({
      name       = string
      number     = string
      id         = string
      project_id = string
    })
    repo = object({
      name       = string
      number     = string
      id         = string
      project_id = string
    })
    domain = object({
      name       = string
      number     = string
      id         = string
      project_id = string
    })
  })
}

variable "sa" {
  type = object({
    email = string
    name  = string
    key   = string
  })
}

variable "oauth_token_id" {
  type = string
}