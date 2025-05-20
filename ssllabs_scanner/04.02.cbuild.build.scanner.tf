/* 
 * Build the scanner image weekly. 
 */
resource "google_cloud_scheduler_job" "weekly-build-scanner" {
  project     = var.project.id
  region      = var.region
  name        = "weekly-build-scanner"
  description = "build scanner weekly at 00:00 on Sunday"
  schedule    = "0 0 * * 0"

  pubsub_target {
    topic_name = google_pubsub_topic.build-scanner.id
    data       = base64encode("weekly build")
  }

  depends_on = [
    google_project_service.cloudscheduler_service
  ]
}

resource "google_cloudbuild_trigger" "build-trigger" {
  project = var.project.id
  name    = "build-${var.repo.sourcerepo.name}"

  pubsub_config {
    topic = google_pubsub_topic.build-scanner.id
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
      args     = ["build", "-t", "gcr.io/${var.project.id}/xascode/ssllabs-scan:latest", "."]
      timeout  = "400s"
    }

    step {
      id       = "1"
      name     = "gcr.io/cloud-builders/docker"
      args     = ["push", "gcr.io/${var.project.id}/xascode/ssllabs-scan:latest"]
      timeout  = "100s"
      wait_for = ["0"]
    }

    step {
      id       = "2"
      name     = "gcr.io/cloud-builders/gcloud"
      entrypoint = "bash"
      args     = ["-c", "cd functions && gcloud functions deploy helloPubSub --trigger-topic MY_TOPIC --runtime nodejs16"]
      timeout  = "100s"
      wait_for = ["0"]
    }
  }

  depends_on = [
    google_project_service.cbuild_service
  ]
}
