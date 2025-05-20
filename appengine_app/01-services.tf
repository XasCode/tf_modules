resource "google_project_service" "iap_service" {
  project = var.project.id
  service = "iap.googleapis.com"
}

resource "google_project_service" "cbuild_service" {
  project = var.project.id
  service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "appengine_service" {
  project = var.project.id
  service = "appengine.googleapis.com"
}

resource "google_project_service" "cloudfunctions_service" {
  project = var.project.id
  service = "cloudfunctions.googleapis.com"
}
