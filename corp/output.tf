output "path" {
  description = "The path of this folder"
  value = "${join("", [var.parent.path, var.name])}/"
}

output "name" {
  description = "The name of the folder. Its format is folders/{folder_id}."
  value = google_folder.folder.name
}

output "project" {
  value = {
    name       = google_project.dns_project[0].name,
    id         = google_project.dns_project[0].id,
    number     = google_project.dns_project[0].number,
    project_id = google_project.dns_project[0].project_id,
  }
}