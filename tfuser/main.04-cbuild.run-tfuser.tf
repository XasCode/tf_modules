resource "google_cloudbuild_trigger" "build-trigger" {
  project = var.project.id
  name    = "run-${var.repo.sourcerepo.name}"

  pubsub_config {
    topic = google_pubsub_topic.run-tfuser.id
  }

  build {
    source {
      repo_source {
        project_id  = var.projects.repo.project_id
        branch_name = var.branch
        repo_name   = var.repo.sourcerepo.name
      }
    }

    step {
      id       = "0"
      name     = "gcr.io/${var.tf_container}/xascode/terraform:latest"
      args     = ["-version"]
      // args     = ["build", "--build-arg", "VERSION=$_VER", "-t", "gcr.io/${var.project.id}/xascode/terraform:latest", "."]
    }

    timeout = "1000s"
  }

  approval_config {
     approval_required = false 
  }

  depends_on = [
    google_project_service.cbuild_service
  ]
}
