/*
 * Create a workspace for each environment/gh repo branch.
 */

resource "tfe_workspace" "workspace" {
  name                  = "${var.tf_org}-${var.managed.name}-${var.environment}"
  organization          = var.tf_org
  auto_apply            = true
  file_triggers_enabled = false
  queue_all_runs        = true
  speculative_enabled   = false
  working_directory     = "terraform"
  vcs_repo {
    identifier         = data.github_repository.repository.full_name
    branch             = var.environment
    ingress_submodules = false
    oauth_token_id     = var.oauth_token_id
    // oauth_token_id     = tfe_oauth_client.xascode.oauth_token_id
  }
}
