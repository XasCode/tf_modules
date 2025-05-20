resource "google_dns_record_set" "cname_www_record_set" {
  count        = var.environment == "main" && var.www ? 1 : 0
  managed_zone = google_dns_managed_zone.public_dns_zone[0].name
  name         = "www.${google_dns_managed_zone.public_dns_zone[0].dns_name}"
  project      = google_project.dns_project[0].project_id
  rrdatas      = [ google_dns_managed_zone.public_dns_zone[0].dns_name ]
  ttl          = 300
  type         = "CNAME"
}
