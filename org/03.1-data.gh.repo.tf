resource "github_repository" "infrastructure" {
  count = var.environment == "main" ? 1 : 0
  name                   = var.infra_repo_name
  visibility             = "private"
  has_issues             = true
  has_projects           = true
  has_wiki               = true
  is_template            = false
  has_downloads          = true
  auto_init              = false
}
