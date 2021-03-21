output "path" {
  description = "Root path from organization name."
  value = "${join("|/|", reverse(split(".", var.name)))}|/|"
}

output "name" {
  description = "The name of the organization resource. Its format is organizations/{org_id}."
  value = data.google_organization.org.name
}