module "ou" {
  source = "github.com/xascode/modules/folder"
  
  name   = var.name
  parent = var.parent
}

module "terraform" {
  source = "github.com/xascode/tf_modules//project?ref=v0.1.0-alpha.4"
  
  name   = "terraform"
  parent = {
    name = module.ou.name
    path = module.ou.path
  }

  billing_account = var.billing_account
}

module "security" {
  source = "github.com/xascode/tf_modules//project?ref=v0.1.0-alpha.4"
  
  name   = "security"
  parent = {
    name = module.ou.name
    path = module.ou.path
  }

  billing_account = var.billing_account
}
/*
module "snapshots" {
 source = "github.com/xascode/tf_modules//project?ref=v0.1.0-alpha.4"
  
  name   = "snapshots"
  parent = {
    name = module.ou.name
    path = module.ou.path
  }

  billing_account = var.billing_account
}
*/