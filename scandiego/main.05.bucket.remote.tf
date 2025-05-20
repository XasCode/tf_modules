resource "google_storage_bucket" "backend" {
  project = var.project.id
  name = "${var.tf_org}_${var.project.id}_${var.environment}_remote_backend"
  force_destroy = true
  location = var.region
}
