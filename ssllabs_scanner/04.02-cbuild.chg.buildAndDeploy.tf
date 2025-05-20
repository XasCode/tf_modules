resource "google_cloudbuild_trigger" "change-trigger" {
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
        "pubsub", "topics", "publish", "${google_pubsub_topic.build-scanner.name}", "--message=\"Changes - build scanner\"", "--project=${var.project.id}"
      ]
      timeout = "30s"
    }

    step {
      name = "gcr.io/cloud-builders/gcloud"
      args = [
        "pubsub", "topics", "publish", "${google_pubsub_topic.deploy-functions.name}", "--message=\"Changes - deploy functions\"", "--project=${var.project.id}"
      ]
      timeout = "30s"
    }
  }

  depends_on = [
    google_project_service.cbuild_service
  ]
}

resource "google_pubsub_topic" "build-scanner" {
  project = var.project.id
  name = "build-${var.repo.sourcerepo.name}"
}

resource "google_pubsub_topic" "deploy-functions" {
  project = var.project.id
  name = "deploy-${var.repo.sourcerepo.name}"
}

resource "google_pubsub_topic_iam_member" "build-member" {
  project = var.project.id
  topic = google_pubsub_topic.build-scanner.name
  role = "roles/pubsub.publisher"
  member = "serviceAccount:${var.projects.repo.number}@cloudbuild.gserviceaccount.com"
}

resource "google_pubsub_topic_iam_member" "deploy-member" {
  project = var.project.id
  topic = google_pubsub_topic.deploy-functions.name
  role = "roles/pubsub.publisher"
  member = "serviceAccount:${var.projects.repo.number}@cloudbuild.gserviceaccount.com"
}


