module "prj_container" {
  source = "github.com/xascode/modules/folder"
  
  name   = var.name
  parent = var.parent
}
