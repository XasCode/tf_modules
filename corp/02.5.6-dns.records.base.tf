resource "google_dns_record_set" "base_a" {
  count        = var.environment == "main" && length(var.base) > 0 ? 1 : 0
  managed_zone = google_dns_managed_zone.public_dns_zone[0].name
  name         = google_dns_managed_zone.public_dns_zone[0].dns_name
  project      = google_project.dns_project[0].project_id
  rrdatas      = var.base
  ttl          = 300
  type         = "A"
}