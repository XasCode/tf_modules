output "path" {
  description = "The path of the project folder."
  value = module.prj_container.path
}

output "name" {
  description = "The name fo the folder. Its format is folders/{folder_id}."
  value = module.prj_container.name
}
