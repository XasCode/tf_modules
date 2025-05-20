resource "github_repository_file" "gh_repo_file_variables" {
  repository          = var.repo.github.name
  branch              = var.environment
  file                = "terraform/variables.tf"
  content             = <<-EOT
    variable "project" {
      type = object({
        path   = string
        name   = string
        id     = string
        number = string
      })
    }

    variable "environment" {
      type = string
    }

    variable "tf_org" {
      type = string
    }

    variable "organization_name" {
      type = string
    }
    EOT
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@xascode.dev"
  overwrite_on_create = true
}
