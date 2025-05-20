resource "google_project_service" "dns_service" {
  count = var.environment == "main" ? 1 : 0
  project = google_project.dns_project[0].id
  service = "dns.googleapis.com"
}

resource "google_project_service" "domains_service" {
  count = var.environment == "main" ? 1 : 0
  project = google_project.dns_project[0].id
  service = "domains.googleapis.com"
}