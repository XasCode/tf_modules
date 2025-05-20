/*
variable "tf_org" {
  type = string
}
*/
variable "name" {
  description = "OU name."
  type        = string
}

variable "tld" {
  description = "Top-level-domain"
  type        = string
}

variable "parent" {
  description = "Path and name identifier for the parent of this OU."
  type = object({
    path = string
    name = string
  })
}

variable "billing_account" {
  type = string
}

variable "organization_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "zone" {
  type = bool
}

variable "records" {
  type = bool
}

variable "mx" {
  type    = list(string)
  default = [
      "5 gmr-smtp-in.l.google.com.",
      "10 alt1.gmr-smtp-in.l.google.com.",
      "20 alt2.gmr-smtp-in.l.google.com.",
      "30 alt3.gmr-smtp-in.l.google.com.",
      "40 alt4.gmr-smtp-in.l.google.com.",
  ]
}

variable "txt" {
  type    = list(string)
  default = []
}

variable "dashlane" {
  type    = list(string)
  default = []
}

variable "www" {
  type    = bool
  default = false
}

variable "base" {
  type    = list(string)
  default = []
}

variable "msft" {
  type    = bool
  default = false
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
  })
}

variable "sa" {
  type = object({
    email = string
    name  = string
    key   = string
  })
}
