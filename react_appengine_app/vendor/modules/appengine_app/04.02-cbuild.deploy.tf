resource "google_pubsub_topic" "topic" {
  project = var.project.id
  name = "build_${var.repo.sourcerepo.name}"
}

resource "google_pubsub_topic_iam_member" "member" {
  project = var.project.id
  topic = google_pubsub_topic.topic.name
  role = "roles/pubsub.publisher"
  member = "serviceAccount:${var.projects.repo.number}@cloudbuild.gserviceaccount.com"
}

resource "google_cloudbuild_trigger" "change_trigger" {
  project = var.projects.repo.project_id
  name    = "change-${var.repo.sourcerepo.name}"

  trigger_template {
    project_id  = var.projects.repo.project_id
    branch_name = var.branch
    repo_name   = var.repo.sourcerepo.name
  }

  build {
    step {
      name = "gcr.io/cloud-builders/gcloud"
      args = [
        "pubsub", "topics", "publish", "${google_pubsub_topic.topic.name}", "--message=\"Hello World!\"", "--project=${var.project.id}"
      ]
      timeout = "30s"
    }
  }
}

resource "google_cloudbuild_trigger" "build-trigger-app" {
  project = var.project.id
  name    = "deploy-${var.repo.sourcerepo.name}"

  pubsub_config {
    topic = google_pubsub_topic.topic.id
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
        "builds", "submit", ".", "--substitutions=_VERSION=${var.branch}"
      ]
      timeout = "600s"
    }
  }

  depends_on = [
    google_project_service.cbuild_service
  ]
}
