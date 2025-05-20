resource "google_dns_record_set" "cname_autodiscover" {
  count        = var.environment == "main" && var.msft ? 1 : 0
  managed_zone = google_dns_managed_zone.public_dns_zone[0].name
  name         = "autodiscover.${google_dns_managed_zone.public_dns_zone[0].dns_name}"
  project      = google_project.dns_project[0].project_id
  rrdatas      = [ "autodiscover.outlook.com." ]
  ttl          = 3600
  type         = "CNAME"
}

resource "google_dns_record_set" "cname_enterpriseenrollment" {
  count        = var.environment == "main" && var.msft ? 1 : 0
  managed_zone = google_dns_managed_zone.public_dns_zone[0].name
  name         = "enterpriseenrollment.${google_dns_managed_zone.public_dns_zone[0].dns_name}"
  project      = google_project.dns_project[0].project_id
  rrdatas      = [ "enterpriseenrollment.manage.microsoft.com." ]
  ttl          = 3600
  type         = "CNAME"
}

resource "google_dns_record_set" "cname_enterpriseregistration" {
  count        = var.environment == "main" && var.msft ? 1 : 0
  managed_zone = google_dns_managed_zone.public_dns_zone[0].name
  name         = "enterpriseregistration.${google_dns_managed_zone.public_dns_zone[0].dns_name}"
  project      = google_project.dns_project[0].project_id
  rrdatas      = [ "enterpriseregistration.windows.net." ]
  ttl          = 3600
  type         = "CNAME"
}

resource "google_dns_record_set" "cname_lyncdiscover" {
  count        = var.environment == "main" && var.msft ? 1 : 0
  managed_zone = google_dns_managed_zone.public_dns_zone[0].name
  name         = "lyncdiscover.${google_dns_managed_zone.public_dns_zone[0].dns_name}"
  project      = google_project.dns_project[0].project_id
  rrdatas      = [ "webdir.online.lync.com." ]
  ttl          = 3600
  type         = "CNAME"
}

resource "google_dns_record_set" "cname_msoid" {
  count        = var.environment == "main" && var.msft ? 1 : 0
  managed_zone = google_dns_managed_zone.public_dns_zone[0].name
  name         = "msoid.${google_dns_managed_zone.public_dns_zone[0].dns_name}"
  project      = google_project.dns_project[0].project_id
  rrdatas      = [ "clientconfig.microsoftonline-p.net." ]
  ttl          = 3600
  type         = "CNAME"
}

resource "google_dns_record_set" "cname_sip" {
  count        = var.environment == "main" && var.msft ? 1 : 0
  managed_zone = google_dns_managed_zone.public_dns_zone[0].name
  name         = "sip.${google_dns_managed_zone.public_dns_zone[0].dns_name}"
  project      = google_project.dns_project[0].project_id
  rrdatas      = [ "sipdir.online.lync.com." ]
  ttl          = 3600
  type         = "CNAME"
}

resource "google_dns_record_set" "srv_sip_tls" {
  count        = var.environment == "main" && var.msft ? 1 : 0
  managed_zone = google_dns_managed_zone.public_dns_zone[0].name
  name         = "_sip._tls.${google_dns_managed_zone.public_dns_zone[0].dns_name}"
  project      = google_project.dns_project[0].project_id
  rrdatas      = [ "100 1 443 sipdir.online.lync.com." ]
  ttl          = 3600
  type         = "SRV"
}

resource "google_dns_record_set" "srv_sipfederationtls_tcp" {
  count        = var.environment == "main" && var.msft ? 1 : 0
  managed_zone = google_dns_managed_zone.public_dns_zone[0].name
  name         = "_sipfederationtls._tcp.${google_dns_managed_zone.public_dns_zone[0].dns_name}"
  project      = google_project.dns_project[0].project_id
  rrdatas      = [ "100 1 5061 sipfed.online.lync.com." ]
  ttl          = 3600
  type         = "SRV"
}
