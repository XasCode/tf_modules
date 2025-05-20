output "path" {
  description = "Root path from organization name."
  value = "${join("/", reverse(split(".", var.name)))}/"
}

output "name" {
  description = "The name of the organization resource. Its format is organizations/{org_id}."
  value = data.google_organization.org.name
}

output "sa" {
  value = {
    email = google_service_account.service_account[0].email,
    name  = google_service_account.service_account[0].name,
    key   = google_service_account_key.key[0].private_key
  }
}

output "projects" {
  value = {
    sa   = {
      name       = google_project.sa_project[0].name,
      id         = google_project.sa_project[0].id,
      number     = google_project.sa_project[0].number,
      project_id = google_project.sa_project[0].project_id,
    },
    repo = {
      name       = google_project.repo_project[0].name,
      id         = google_project.repo_project[0].id,
      number     = google_project.repo_project[0].number,
      project_id = google_project.repo_project[0].project_id
    }
  }
}

output "oauth_token_id" {
  value = tfe_oauth_client.infrastructure[0].oauth_token_id
}
