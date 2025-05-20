data "github_repository" "infrastructure" {
  full_name = "${var.infra_repo_org}/${var.infra_repo_name}"
}

resource "github_branch" "branch" {
  count         = contains(var.envs, var.environment) ? 1 : 0
  repository    = data.github_repository.infrastructure.name
  branch        = var.environment
  depends_on    = [
    data.github_repository.infrastructure
  ]
}
