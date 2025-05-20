terraform {
  required_providers {
    github = {
      source  = "integrations/github"
    }
    tfe = {
      source = "hashicorp/tfe"
    }
  }
}

provider "github" {
  token = var.gh_token
  owner = var.gh_org
}

provider "tfe" {
  token    = var.tf_token
}
