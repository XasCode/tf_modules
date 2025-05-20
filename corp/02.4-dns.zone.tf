resource "google_dns_managed_zone" "public_dns_zone" {
  count         = var.environment == "main" && var.zone == true ? 1 : 0
  project       = google_project.dns_project[0].project_id
  dns_name      = "${var.name}.${var.tld}."
  name          = var.name
  description   = "${var.name}.${var.tld}."
  visibility    = "public"
  force_destroy = false
}
