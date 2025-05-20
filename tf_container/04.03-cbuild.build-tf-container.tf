resource "google_cloudbuild_trigger" "build-trigger" {
  project = var.project.id
  name    = "build-${var.repo.sourcerepo.name}"

  pubsub_config {
    topic = google_pubsub_topic.build-tf-container.id
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
      name     = "gcr.io/cloud-builders/docker"
      args     = ["build", "--build-arg", "VERSION=$_VER", "-t", "gcr.io/${var.project.id}/xascode/terraform:latest", "."]
    }

    step {
      id       = "1"
      name     = "gcr.io/cloud-builders/docker"
      args     = ["push", "gcr.io/${var.project.id}/xascode/terraform:latest"]
      wait_for = ["0"]
    }

    timeout = "1000s"
  }

  substitutions = {
    _VER = "$(body.message.data)"
  }

  approval_config {
     approval_required = false 
  }

  depends_on = [
    google_project_service.cbuild_service
  ]
}
