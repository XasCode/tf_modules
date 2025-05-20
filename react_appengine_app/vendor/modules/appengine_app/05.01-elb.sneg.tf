resource "google_compute_region_network_endpoint_group" "appengine_neg" {
  project = var.project.id
  name                  = "appengine-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  app_engine {
    service = "default"
    version = "devl"
  }
}

resource "google_compute_backend_service" "default" {
  provider = google-beta

  project = var.project.id
  name    = "backend"

  protocol = "HTTPS"
  connection_draining_timeout_sec = 10
  enable_cdn                      = false
  #custom_request_headers          = ["host: ${google_compute_global_network_endpoint.proxy.fqdn}"]
  #custom_response_headers         = ["X-Cache-Hit: {cdn_cache_status}"]
  custom_response_headers         = ["Strict-Transport-Security: max-age=31536000; includeSubdomains;"]

  # To achieve a null backend security_policy, set each.value.security_policy to "" (empty string), otherwise, it fallsback to var.security_policy.
  #security_policy = lookup(each.value, "security_policy") == "" ? null : (lookup(each.value, "security_policy") == null ? var.security_policy : each.value.security_policy)

  backend {
    group = google_compute_region_network_endpoint_group.appengine_neg.id
  }
}

resource "google_compute_url_map" "default" {
  project         = var.project.id
  name            = "url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_url_map" "https_redirect" {
  project = var.project.id
  name    = "https-redirect"
  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

resource "google_compute_target_http_proxy" "default" {
  project = var.project.id
  name    = "http-proxy"
  url_map = google_compute_url_map.https_redirect.id
}

resource "google_compute_target_https_proxy" "default" {
  project = var.project.id
  name    = "https-proxy"
  url_map = google_compute_url_map.default.id

  ssl_certificates = [ google_compute_managed_ssl_certificate.default.id ]
  ssl_policy       = google_compute_ssl_policy.ssl-policy.id
}

resource "google_compute_managed_ssl_certificate" "default" {
  provider = google-beta
  project  = var.project.id
  name     = "cert"

  lifecycle {
    create_before_destroy = true
  }

  managed {
    domains = [ "test-devl.xascode.dev" ]
  }
}

resource "google_compute_ssl_policy" "ssl-policy" {
  project  = var.project.id
  name            = "ssl-policy"
  profile         = "RESTRICTED"
  min_tls_version = "TLS_1_2"
}

resource "google_compute_global_forwarding_rule" "http" {
  project    = var.project.id
  name       = "http"
  target     = google_compute_target_http_proxy.default.id
  ip_address = google_compute_global_address.default.address
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "https" {
  project    = var.project.id
  name       = "https"
  target     = google_compute_target_https_proxy.default.id
  ip_address = google_compute_global_address.default.address
  port_range = "443"
}

resource "google_compute_global_address" "default" {
  project    = var.project.id
  name       = "address"
  ip_version = "IPV4"
}

resource "google_dns_record_set" "a_record_set" {
  project      = var.projects.domain.project_id
  managed_zone = "xascode"
  name         = "test-devl.xascode.dev."
  ttl          = 300
  type         = "A"
  rrdatas = [google_compute_global_address.default.address]
}

resource "google_dns_record_set" "caa_record_set" {
  project      = var.projects.domain.project_id
  managed_zone = "xascode"
  name         = "test-devl.xascode.dev."
  ttl          = 300
  type         = "CAA"
  rrdatas      = [
    "0 issue \"pki.goog\"",
    "0 issue \"letsencrypt.org\""
  ]
}











