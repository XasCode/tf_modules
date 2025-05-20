resource "google_cloud_scheduler_job" "weekly-build-scanner" {
  project     = var.project.id
  region      = var.region
  name        = "weekly-build-scanner"
  description = "build scanner weekly at 00:00 on Sunday"
  schedule    = "0 0 * * 0"

  pubsub_target {
    topic_name = google_pubsub_topic.get-tf-container-ver.id
    data       = base64encode("weekly build")
  }

  depends_on = [
    google_project_service.cloudscheduler_service
  ]
}

resource "google_cloudbuild_trigger" "get-trigger" {
  project = var.project.id
  name    = "get-${var.repo.sourcerepo.name}"

  pubsub_config {
    topic = google_pubsub_topic.get-tf-container-ver.id
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
      name = "gcr.io/cloud-builders/gcloud"
      entrypoint = "bash"
      args = [ "-c", "gcloud pubsub topics publish ${google_pubsub_topic.build-tf-container.name} --message=\"$$(curl https://raw.githubusercontent.com/hashicorp/terraform/main/.go-version -so -)\" --project=${var.project.id}"
      ]
      timeout = "30s"
    }
  }

  approval_config {
     approval_required = false 
  }

  depends_on = [
    google_project_service.cbuild_service
  ]
}
