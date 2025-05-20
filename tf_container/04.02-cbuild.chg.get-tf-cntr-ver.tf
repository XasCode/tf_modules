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
        "pubsub", "topics", "publish", "${google_pubsub_topic.get-tf-container-ver.name}", "--message=\"Changes - build tf container\"", "--project=${var.project.id}"
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

resource "google_pubsub_topic" "get-tf-container-ver" {
  project = var.project.id
  name = "get-${var.repo.sourcerepo.name}"
}

resource "google_pubsub_topic" "build-tf-container" {
  project = var.project.id
  name = "build-${var.repo.sourcerepo.name}"
}

resource "google_pubsub_topic_iam_member" "get-member" {
  project = var.project.id
  topic = google_pubsub_topic.get-tf-container-ver.name
  role = "roles/pubsub.publisher"
  member = "serviceAccount:${var.projects.repo.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.cbuild_service
  ]
}

resource "google_pubsub_topic_iam_member" "build-member" {
  project = var.project.id
  topic = google_pubsub_topic.build-tf-container.name
  role = "roles/pubsub.publisher"
  member = "serviceAccount:${var.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.cbuild_service
  ]
}
