/*
 * Create a Github repository to store our project files. We'll
 * use a template to populate with a sample app.
 */

resource "github_repository" "repository" {
  count = var.environment == "devl" ? 1 : 0

  name             = var.managed.name
  description      = "Automated"

  visibility       = "public"
  has_issues       = false
  has_projects     = false
  has_wiki         = false
  is_template      = false
  has_downloads    = false
  auto_init        = true
  license_template = "mit"

  template {
    owner      = var.gh_org
    repository = var.app_type == "ssllabs-scan" ? "empty" : var.app_type == "tf" ? "empty" : var.app_type == "tfuser" ? "empty" : var.app_type
  }
}

data "github_repository" "repository" {
  full_name  = "${var.gh_org}/${var.managed.name}"

  depends_on = [github_repository.repository]
}
