output "repo" {
  value = {
    github = {
      name = data.github_repository.repository.name
      full_name = data.github_repository.repository.full_name
    }
    sourcerepo = {
      name = google_sourcerepo_repository.repository.name
    }
  }
}
