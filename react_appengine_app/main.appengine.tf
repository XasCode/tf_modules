module "appengine_app" {
  source        = "./vendor/modules/appengine_app"
  
  tf_org        = var.tf_org
  environment   = var.environment
  project       = var.project
  branch        = var.branch
  region        = var.region

  repo          = var.repo
  iap_protected = var.iap_protected
  domain_name   = var.domain_name

  projects      = var.projects
}
