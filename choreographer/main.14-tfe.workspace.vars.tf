/*
 * Define the variables to be used by TFE when deploying project resources.
 */
resource "tfe_variable" "gc" {
  key                   = "GOOGLE_CREDENTIALS"
  value                 = trimspace(replace(base64decode(var.sa.key),"\n",""))
  category              = "env"
  workspace_id          = tfe_workspace.workspace.id
  sensitive             = true
}

resource "tfe_variable" "environment" {
  key                   = "environment"
  value                 = var.environment
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace.id
}

resource "tfe_variable" "project" {
  key                   = "project"
  value                 = replace(jsonencode(var.managed), "/(\".*?\"):/", "$1 = ")
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace.id
  hcl                   = true
}

resource "tfe_variable" "tf_org" {
  key                   = "tf_org"
  value                 = var.tf_org
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace.id
}

resource "tfe_variable" "organization_name" {
  key                   = "organization_name"
  value                 = var.organization_name
  category              = "terraform"
  workspace_id          = tfe_workspace.workspace.id
}

resource "tfe_variable" "projects" {
  key          = "projects"
  value        = jsonencode(var.projects)
  category     = "terraform"
  workspace_id = tfe_workspace.workspace.id
}