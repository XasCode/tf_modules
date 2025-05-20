terraform {
  required_providers {
    github = {
      source  = "integrations/github"
    }
    archive = {
      source = "hashicorp/archive"
    }
    tfe = {
      source = "hashicorp/tfe"
    }
  }
}
