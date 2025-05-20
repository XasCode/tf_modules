/*
 * Create branches within the github repo for each environment.
 */

resource "github_branch" "branch" {
  repository = data.github_repository.repository.name
  branch     = var.environment
  depends_on = [github_repository.repository]
}

resource "github_branch_default" "branch_default" {
  count      = var.environment == "devl" ? 1 : 0
  repository = data.github_repository.repository.name
  branch     = github_branch.branch.branch
  depends_on = [github_repository.repository]
}
