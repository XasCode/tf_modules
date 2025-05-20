resource "google_project" "sa_project" {
  count               = var.environment == "main"  ? 1 : 0
  project_id          = "${var.tf_org}-terraform-admin"
  name                = "${var.tf_org}-terraform-admin"

  billing_account     = var.billing_account
  org_id              = var.organization_id
  auto_create_network = false
}
