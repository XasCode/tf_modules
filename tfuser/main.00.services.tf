resource "google_project_service" "cbuild_service" {
  project = var.project.id
  service = "cloudbuild.googleapis.com"
}
/*
resource "google_project_service" "cloudscheduler_service" {
  project = var.project.id
  service = "cloudscheduler.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager_service" {
  project = var.project.id
  service = "cloudresourcemanager.googleapis.com"
}
*/