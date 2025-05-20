resource "tfe_oauth_client" "infrastructure" {
  count            = var.environment == "main" ? 1 : 0
  organization     = lower(var.gh_org)
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.gh_token
  service_provider = "github"
}
