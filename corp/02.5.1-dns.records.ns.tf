resource "google_dns_record_set" "ns_record_set" {
  count        = var.environment == "main" && var.records == true ? 1 : 0
  managed_zone = google_dns_managed_zone.public_dns_zone[0].name
  name         = google_dns_managed_zone.public_dns_zone[0].dns_name
  project      = google_project.dns_project[0].project_id
  rrdatas      = google_dns_managed_zone.public_dns_zone[0].name_servers
  ttl          = 21600
  type         = "NS"
}
