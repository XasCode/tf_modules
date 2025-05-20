// Provide the service account with needed permissions

resource "google_folder_iam_binding" "folder" {
  count   = var.environment == "main" ? 1 : 0
  folder  = google_folder.folder.name
  
  role    = "roles/owner"
  members = [
    "serviceAccount:${var.sa.email}"
  ]
}
