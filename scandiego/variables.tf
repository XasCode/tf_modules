variable "tf_org" {
  type = string
}

variable "environment" {
  type = string
}

variable "project" {
  type = object({
    path   = string
    name   = string
    id     = string
    number = string
  })
}

variable "branch" {
  type = string
}

variable "repo" {
  type = object({
    github = object({
      name = string
      full_name = string
    })
    sourcerepo = object({
      name = string
    })
  })
}

variable "region" {
  type = string
}

variable "iap_protected" {
  type = bool
}

variable "domain_name" {
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

variable "tf_container" {
  type = string
}