

resource "github_repository_file" "gh_repo_file_sd_bucket" {
  repository          = var.repo.github.name
  branch              = var.environment
  file                = "scandiego/bucket.tf"
  content             = <<-EOT
    resource "google_storage_bucket" "bucket" {
      project = "${var.project.id}"
      name = "${var.tf_org}_${var.project.id}_${var.environment}_test_bucket"
      force_destroy = true
      location = "${var.region}"
    }
    EOT
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@xascode.dev"
  overwrite_on_create = true
}
