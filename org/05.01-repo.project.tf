resource "random_id" "project" {
  count       = var.environment == "main" ? 1 : 0
  byte_length = 3
}

resource "google_project" "repo_project" {
  count               = var.environment == "main"  ? 1 : 0
  project_id          = "${var.tf_org}-choreo-${random_id.project[0].hex}"
  name                = "${var.tf_org}-choreographer"

  billing_account     = var.billing_account
  org_id              = var.organization_id
  auto_create_network = false
}
