resource "random_id" "project" {
  count       = var.environment == "main" ? 1 : 0
  byte_length = 3
}

resource "google_project" "dns_project" {
  count               = var.environment == "main" ? 1 : 0
  project_id          = var.name == "canoekayak" ? "${var.name}-${random_id.project[0].hex}" : var.name
  name                = "${var.name}-domain"
  folder_id           = google_folder.folder.name

  billing_account     = var.billing_account
  auto_create_network = false
}
