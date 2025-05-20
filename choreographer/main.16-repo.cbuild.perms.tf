/*
 * Provide the default cloud build service account with permissions to
 * write to source repo.
 */
resource "google_sourcerepo_repository_iam_binding" "binding" {
  project = var.projects.repo.project_id
  repository = google_sourcerepo_repository.repository.name
  role = "roles/source.writer"
  members = [
    "serviceAccount:${var.projects.repo.number}@cloudbuild.gserviceaccount.com",
  ]
}
