resource "google_project_service" "appengine_svc" {
  count = var.environment == "main" ? 1 : 0
  project = google_project.sa_project[0].id
  service = "appengine.googleapis.com"
}

resource "google_project_service" "pubsub_svc" {
  count = var.environment == "main" ? 1 : 0
  project = google_project.sa_project[0].id
  service = "pubsub.googleapis.com"
}

resource "google_project_service" "cloudbuild_svc" {
  count = var.environment == "main" ? 1 : 0
  project = google_project.sa_project[0].id
  service = "cloudbuild.googleapis.com"
}
