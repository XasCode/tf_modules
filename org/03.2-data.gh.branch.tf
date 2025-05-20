resource "github_branch" "branch" {
  count      = var.environment == "main" ? 1 : 0
  repository = var.infra_repo_name
  branch     = var.environment
}

resource "github_branch_default" "default_main" {
  count      = var.environment == "main" ? 1 : 0
  repository = var.infra_repo_name
  branch     = github_branch.branch[0].branch
}
