output "path" {
  description = "Root path from organization name."
  value = "${join("|/|", reverse(split(".", var.organization_name)))}|/|"
}

output "name" {
  description = "The name fo the organization resource. Its format is organizations/{org_id}."
}