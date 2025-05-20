resource "github_repository_file" "gh_repo_file_sd_remote" {
  repository          = var.repo.github.name
  branch              = var.environment
  file                = "scandiego/remote.tf"
  content             = <<-EOT
    data "terraform_remote_state" "remote" {
      backend = "gcs"
      config = {
        bucket  = "${var.tf_org}_${var.project.id}_${var.environment}_remote_backend"
        prefix  = "${var.environment}"
      }
    }
    EOT
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@xascode.dev"
  overwrite_on_create = true

  depends_on = [
    "google_storage_bucket.backend"
  ]
}
