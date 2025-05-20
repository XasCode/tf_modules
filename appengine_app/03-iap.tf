resource "google_iap_brand" "project_brand" {
  count = var.iap_protected ? 1 : 0

  support_email     = "orgadmins@xascode.dev"
  application_title = "Cloud IAP protected Application - ${var.project.name} - ${var.environment}"
  project           = google_project_service.iap_service.project
}

resource "google_iap_client" "iap_client" {
  count = var.iap_protected ? 1 : 0

  display_name = "${var.project.name} - ${var.environment} - client"
  brand        =  google_iap_brand.project_brand[0].name
}

resource "google_iap_web_type_app_engine_iam_binding" "binding" {
  count = var.iap_protected ? 1 : 0

  project = google_app_engine_application.app.project
  app_id  = google_app_engine_application.app.app_id
  role    = "roles/iap.httpsResourceAccessor"
  members = [
    "domain:xascode.dev",
  ]
}
