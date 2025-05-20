resource "github_repository_file" "gh_repo_file_cloudbuild_yaml" {
  repository          = var.repo.github.name
  branch              = var.environment
  file                = "cloudbuild.yaml"
  content             = <<-EOT
    steps:
    - name: 'gcr.io/${var.project.id}/xascode/ssllabs-scan'
      entrypoint: 'bash'
      args:
        - '-c'
        - |
          /tmp/ssllabs-scan-master/ssllabs-scan-v3 -quiet -grade -usecache $${_URL} > /workspace/msg
    - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk'
      entrypoint: 'bash'
      args: [ '-c', 'gcloud pubsub topics publish MY_TOPIC --message=$${_URL}\|$(cat /workspace/msg | grep "\":\"" | cut -f 4 -d \" | cut -f 2 -d \" | sed -z "s/\n/,/g;s/,$/\n/") --project=$PROJECT_ID' ]
    EOT
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@xascode.dev"
  overwrite_on_create = true

  depends_on = [
    github_repository_file.gh_repo_file_dockerfile
  ]
}
