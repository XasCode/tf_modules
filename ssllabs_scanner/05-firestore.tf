resource "google_project_service" "firestore_api" {
  project = var.project.id
  service            = "firestore.googleapis.com"
  disable_on_destroy = false
}

resource "google_app_engine_application" "app" {
  project = var.project.id
  location_id = substr(var.region, 0, length(var.region)-1)
  database_type = "CLOUD_FIRESTORE"
}

resource "google_project_iam_member" "firestore_user" {
  project = var.project.id
  role   = "roles/datastore.user"
  member = "serviceAccount:${var.project.number}@cloudbuild.gserviceaccount.com"
}

resource "google_pubsub_topic" "my_topic" {
  project = var.project.id
  name = "MY_TOPIC"
}
