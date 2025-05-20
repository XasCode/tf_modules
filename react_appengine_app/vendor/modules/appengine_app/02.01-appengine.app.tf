/*
 * Enable app engine for the project.
 */

resource "google_app_engine_application" "app" {
  project = var.project.id
  location_id = substr(var.region, 0, length(var.region)-1)

  dynamic iap {
    for_each = var.iap_protected ? [1] : []
    content {
      enabled              = true
      oauth2_client_id     = google_iap_client.iap_client[0].client_id
      oauth2_client_secret = google_iap_client.iap_client[0].secret
    }
  }
}
