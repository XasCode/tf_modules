resource "github_repository_file" "gh_repo_file_archive" {
  repository          = var.repo.github.name
  branch              = var.environment
  file                = "terraform/main.archive.tf"
  content             = <<-EOT
    data "archive_file" "srcfiles" {
      type        = "zip"
      output_path = "src.zip"
      source_dir  = "../"
    }

    resource "google_storage_bucket_object" "archive" {
      name   = "src-$${filemd5(data.archive_file.srcfiles.output_path)}.zip"
      bucket = "$${var.tf_org}_$${var.project.id}_$${var.environment}_source_bucket"
      source = data.archive_file.srcfiles.output_path
    }
    EOT
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@xascode.dev"
  overwrite_on_create = true

  depends_on = [
    github_repository_file.gh_repo_file_dockerfile,
  ]
}
