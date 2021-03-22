resource "random_id" "project" {
  byte_length = 3
}

resource "google_project" "project" {
    auto_create_network = false
    billing_account     = var.billing_account
    folder_id           = var.parent.name
    labels              = {}
    name                = "${var.name}"
    project_id          = "${var.name}-${random_id.project.hex}"
    timeouts {}
}
