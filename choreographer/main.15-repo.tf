/*
 * Upon notification of changes to our project's GH repo, we will
 * sync the GH repo to Google sourcerepo
 */

resource "google_sourcerepo_repository" "repository" {
  project = var.projects.repo.project_id
  name = "${var.tf_org}-${var.managed.name}-repo"
  depends_on = [ google_project_service.sourcerepo ]
}
