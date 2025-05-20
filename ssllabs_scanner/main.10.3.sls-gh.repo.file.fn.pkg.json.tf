resource "github_repository_file" "gh_repo_file_pkg" {
  repository          = var.repo.github.name
  branch              = var.environment
  file                = "functions/package.json"
  content             = <<-EOT
    {
      "name": "helloworld",
      "version": "1.0.0",
      "description": "",
      "main": "index.js",
      "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1"
      },
      "keywords": [],
      "author": "",
      "license": "MIT",
      "dependencies": {
        "@google-cloud/functions-framework": "^3.0.0",
        "firebase-admin": "^10.0.2"
      }
    }
    EOT
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@xascode.dev"
  overwrite_on_create = true

  depends_on = [
    github_repository_file.gh_repo_file_dockerfile,
    github_repository_file.gh_repo_file_cloudbuild_yaml
  ]
}
