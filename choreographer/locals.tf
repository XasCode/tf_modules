data "terraform_remote_state" "terraform-devl" {
  backend = "remote"
  config = {
    organization = "xascode"
    workspaces = {
      name = "terraform-devl"
    }
  }
}

data "terraform_remote_state" "terraform-test" {
  backend = "remote"
  config = {
    organization = "xascode"
    workspaces = {
      name = "terraform-test"
    }
  }
}

data "terraform_remote_state" "terraform-prod" {
  backend = "remote"
  config = {
    organization = "xascode"
    workspaces = {
      name = "terraform-prod"
    }
  }
}

locals {
  // project = [for x in data.terraform_remote_state.terraform-devl.outputs.projects: x if x.path == var.project_path][0]
  // parent = [for x in data.terraform_remote_state.terraform-devl.outputs.folders: x if x.path == "${join("/", slice(split("/", var.project_path), 0, length(split("/", var.project_path))-2))}/"][0]
  region = "us-central1"
  branch = var.environment == "devl" ? "main" : var.environment
}
