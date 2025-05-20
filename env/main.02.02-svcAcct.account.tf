// Provide the service account with needed permissions

resource "google_folder_iam_binding" "folder" {
  count   = contains(var.envs, var.environment) ? 1 : 0
  folder  = module.env.name
  
  role    = "roles/owner"
  members = [
    "serviceAccount:${var.sa.email}",
  ]
}
