output "path" {
  description = "The path of the env folder"
  value = module.env.path
}

output "name" {
  description = "The name of the folder. Its format is folders/{folder_id}."
  value = module.env.name
}
