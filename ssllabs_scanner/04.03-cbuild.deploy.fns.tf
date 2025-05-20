resource "google_cloudbuild_trigger" "deploy-trigger" {
  project = var.project.id
  name    = "deploy-${var.repo.sourcerepo.name}"

  pubsub_config {
    topic = google_pubsub_topic.deploy-functions.id
  }

  build {
    source {
      repo_source {
        project_id  = var.projects.repo.project_id
        branch_name = var.branch
        repo_name   = var.repo.sourcerepo.name
      }
    }

    step {
      id       = "0"
      name     = "gcr.io/cloud-builders/gcloud"
      entrypoint = "bash"
      args     = ["-c", "cd functions && gcloud functions deploy helloPubSub --trigger-topic MY_TOPIC --runtime nodejs16"]
      timeout  = "200s"
    }

    step {
      id       = "1"
      name     = "gcr.io/cloud-builders/gcloud"
      entrypoint = "bash"
      args     = ["-c", "cd functions && gcloud functions deploy helloGET --runtime nodejs16 --trigger-http"]
      timeout  = "200s"
    }
  }

  depends_on = [
    google_project_service.cbuild_service
  ]
}
