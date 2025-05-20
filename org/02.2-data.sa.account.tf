resource "google_service_account" "service_account" {
  count        = var.environment == "main"  ? 1 : 0
  account_id   = "terraform"
  disabled     = false
  display_name = "Terraform admin account"
  project      = google_project.sa_project[count.index].name
}

resource "google_service_account_key" "key" {
  count = var.environment == "main" ? 1 : 0
  service_account_id = google_service_account.service_account[count.index].name
  public_key_type    = "TYPE_X509_PEM_FILE"
}
