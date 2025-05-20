resource "google_folder" "folder" {
  display_name = var.name
  parent       = var.parent.name
}

/*
module "util" {
  source = "./vendor/modules/folder"

  name   = "util"
  parent = {
    name = module.corp.name
    path = module.corp.path
  }

  envs        = var.envs
  environment = var.environment
}

module "terraform" {
  source = "./vendor/modules/project"
  
  name   = "terraform"
  parent = {
    name = module.corp.name
    path = module.corp.path
  }

  billing_account = var.billing_account

  envs        = var.envs
  environment = var.environment
}
*/