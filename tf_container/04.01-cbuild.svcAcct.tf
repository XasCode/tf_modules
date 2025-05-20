resource "google_project_iam_member" "act_as" {
  project = var.project.id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${var.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.cbuild_service
  ]
}

resource "google_project_iam_member" "logs_writer" {
  project = var.project.id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${var.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.cbuild_service
  ]
}

resource "google_project_iam_member" "source_reader" {
  project = var.projects.repo.project_id
  role    = "roles/source.reader"
  member  = "serviceAccount:${var.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.cbuild_service
  ]
}

resource "google_project_iam_member" "appengine_deployer" {
  project = var.project.id
  role    = "roles/appengine.deployer"
  member  = "serviceAccount:${var.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.cbuild_service
  ]
}

resource "google_project_iam_member" "object_admin" {
  project = var.project.id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${var.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.cbuild_service
  ]
}

resource "google_project_iam_member" "cloudbuild_editor" {
  project = var.project.id
  role    = "roles/cloudbuild.builds.editor"
  member  = "serviceAccount:${var.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.cbuild_service
  ]
}

resource "google_project_iam_member" "appengine_service_admin" {
  project = var.project.id
  role    = "roles/appengine.serviceAdmin"
  member  = "serviceAccount:${var.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.cbuild_service
  ]
}

resource "google_project_iam_member" "functions_admin" {
  project = var.project.id
  role    = "roles/cloudfunctions.admin"
  member  = "serviceAccount:${var.project.number}@cloudbuild.gserviceaccount.com"
  depends_on = [
    google_project_service.cbuild_service
  ]
}
