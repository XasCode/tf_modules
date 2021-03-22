output "path" {
  description = "The path of this project."
  value = "${join("", [var.parent.path, var.name])}|/|"
}

output "name" {
  description = "The name of the project."
  value = google_project.project.name
}

output "id" {
  description = "The project_id."
  value = google_project.project.project_id
}

output "number" {
  description = "The project number."
  value = google_project.project.number
}