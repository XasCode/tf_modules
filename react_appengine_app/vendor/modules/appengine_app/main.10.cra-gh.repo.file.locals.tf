resource "github_repository_file" "gh_repo_file_locals" {
  repository          = var.repo.github.name
  branch              = var.environment
  file                = "terraform/locals.tf"
  content             = <<-EOT
    locals {
      branch  = var.environment
    }
    EOT
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@xascode.dev"
  overwrite_on_create = true

  depends_on = [
    github_repository_file.gh_repo_file_variables
  ]
}
