module "env" {
  source = "./vendor/modules/folder"
  
  name   = var.name
  parent = var.parent
}
