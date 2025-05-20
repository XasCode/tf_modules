resource "tfe_variable" "environment" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "environment"
  value                 = var.environment
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
}

resource "tfe_variable" "parent" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "parent"
  value                 = jsonencode(module.env)
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
}

resource "tfe_variable" "projects" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "projects"
  value                 = jsonencode(var.projects)
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
}

resource "tfe_variable" "sa" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "sa"
  value                 = jsonencode(var.sa)
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
  sensitive             = true
}

resource "tfe_variable" "organization_name" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "organization_name"
  value                 = var.organization_name
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[count.index].id
}

resource "tfe_variable" "organization_id" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "organization_id"
  value                 = var.organization_id
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
}

resource "tfe_variable" "billing_account" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "billing_account"
  value                 = var.billing_account
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
}

resource "tfe_variable" "tf_org" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "tf_org"
  value                 = var.tf_org
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
}

resource "tfe_variable" "gh_org" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "gh_org"
  value                 = var.gh_org
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
}

resource "tfe_variable" "gc" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "GOOGLE_CREDENTIALS"
  value                 = trimspace(replace(base64decode(var.sa.key),"\n",""))
  category              = "env"
  workspace_id          = tfe_workspace.workspace[0].id
  sensitive             = true
}

resource "tfe_variable" "tf_token" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "tf_token"
  value                 = var.tf_token
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
  sensitive             = true
}

resource "tfe_variable" "gh_token" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "gh_token"
  value                 = var.gh_token
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
  sensitive             = true
}

resource "tfe_variable" "sg" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "sg"
  value                 = var.sg
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
  sensitive             = true
}

resource "tfe_variable" "build" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "build"
  value                 = var.build
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
  sensitive             = true
}

resource "tfe_variable" "oauth_token_id" {
  count                 = contains(var.envs, var.environment) ? 1 : 0
  key                   = "oauth_token_id"
  value                 = var.oauth_token_id
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace[0].id
  sensitive             = true
}