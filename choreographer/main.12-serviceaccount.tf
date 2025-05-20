resource "google_project_iam_binding" "project" {
  project = var.managed.id 
  role    = "roles/owner"
  members = [
    "serviceAccount:${var.sa.email}",
  ]
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket  = google_storage_bucket.bucket.name
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:${var.sa.email}",
  ]
}

resource "google_storage_bucket_iam_binding" "object_binding" {
  bucket  = google_storage_bucket.bucket.name
  role    = "roles/storage.objectAdmin"
  members = [
    "serviceAccount:${var.sa.email}",
  ]
}
