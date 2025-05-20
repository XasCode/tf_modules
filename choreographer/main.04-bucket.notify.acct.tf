/*
 * Get the email address of the project's unique automatic Google Cloud Storage service account.
 */

data "google_storage_project_service_account" "gcs_account" {
  project = var.projects.repo.project_id
}
