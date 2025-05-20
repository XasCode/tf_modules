/*
 * Run a scan.
 */
resource "google_cloud_scheduler_job" "weekly-scan" {
  project     = var.project.id
  region      = var.region
  name        = "weekly-scan"
  description = "run scanner weekly at 01:00 on Sunday"
  schedule    = "0 1 * * 0"

  pubsub_target {
    topic_name = google_pubsub_topic.scan.id
    data       = base64encode("https://test-devl.xascode.dev")
  }

  depends_on = [
    google_project_service.cloudscheduler_service
  ]
}

resource "google_pubsub_topic" "scan" {
  project = var.project.id
  name = "scan-${var.repo.sourcerepo.name}"
}

resource "google_cloudbuild_trigger" "trigger-scan" {
  project = var.project.id
  name    = "scan-${var.repo.sourcerepo.name}"

  pubsub_config {
    topic = google_pubsub_topic.scan.id
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
      name = "gcr.io/google.com/cloudsdktool/cloud-sdk"
      entrypoint = "gcloud"
      args = [
        "builds", "submit", ".", "--substitutions=_URL=$_REPLACE"
      ]
      timeout = "500s"
    }
  }

  substitutions = {
    _REPLACE = "$(body.message.data)"
  }

  depends_on = [
    google_project_service.cbuild_service
  ]
}
