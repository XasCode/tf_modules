resource "tfe_workspace" "workspace" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  name                  = "${var.infra_repo_name}-${local.corp}-${var.environment}"
  organization          = var.tf_org
  auto_apply            = true
  file_triggers_enabled = false
  queue_all_runs        = true
  speculative_enabled   = false
  working_directory     = "terraform/${var.infra_repo_name}-${local.corp}"
  vcs_repo {
    identifier         = data.github_repository.infrastructure.full_name
    branch             = github_branch.branch[0].branch
    ingress_submodules = false
    oauth_token_id     = var.oauth_token_id
    //oauth_token_id     = tfe_oauth_client.infrastructure[0].oauth_token_id
  }
}
