resource "google_project_service" "sourcerepo" {
  project = var.projects.repo.project_id
  service = "sourcerepo.googleapis.com"
  timeouts {
    create = "3m"
    update = "6m"
  }
  disable_dependent_services = true
}

resource "google_project_service" "cloud_build" {
  project = var.projects.repo.project_id
  service = "cloudbuild.googleapis.com"
  timeouts {
    create = "3m"
    update = "6m"
  }
  disable_dependent_services = true
}

resource "google_project_service" "serviceusage" {
  project = var.projects.repo.project_id
  service = "serviceusage.googleapis.com"
  timeouts {
    create = "3m"
    update = "6m"
  }
  disable_dependent_services = true
}

resource "google_project_service" "cloudresourcemanager" {
  project = var.projects.repo.project_id
  service = "cloudresourcemanager.googleapis.com"
  timeouts {
    create = "3m"
    update = "6m"
  }
  disable_dependent_services = true
}

resource "google_project_service" "iam" {
  project = var.projects.repo.project_id
  service = "iam.googleapis.com"
  timeouts {
    create = "3m"
    update = "6m"
  }
  disable_dependent_services = true
}

resource "google_project_service" "appengine" {
  project = var.projects.repo.project_id
  service = "appengine.googleapis.com"
  timeouts {
    create = "3m"
    update = "6m"
  }
  disable_dependent_services = true
}
