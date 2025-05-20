/*
 * Run this build upon notification of changes to the GH source code.
 * Notification occurs when TFE is triggered by a GH change, which kicks
 * off TF deployment to upload an archive file to a storage bucket, which
 * is set up to publish to a pubsub topic.
 */

resource "google_cloudbuild_trigger" "build-trigger" {
  project = var.projects.repo.project_id
  name    = google_sourcerepo_repository.repository.name

  pubsub_config {
    topic = google_pubsub_topic.topic.id
  }

  build {
    step {
      id = "0"
      name = "gcr.io/cloud-builders/git"
      entrypoint = "git"
      args = ["clone", "https://source.developers.google.com/p/${var.projects.repo.project_id}/r/${google_sourcerepo_repository.repository.name}"]
      timeout = "30s"
    }
    step {
      id = "1"
      name = "gcr.io/cloud-builders/git"
      entrypoint = "bash"
      args = [
        "-c",
        "cd ${google_sourcerepo_repository.repository.name} && git config init.defaultBranch devl && git branch -m ${var.environment}"
      ]
      timeout = "30s"
      wait_for = ["0"]
    }
    step {
      id = "2"
      name = "gcr.io/cloud-builders/git"
      entrypoint = "bash"
      args = [
        "-c",
        "cd ${google_sourcerepo_repository.repository.name} && git remote add upstream https://github.com/${data.github_repository.repository.full_name}.git && git fetch upstream"
      ]
      timeout = "30s"
      wait_for = ["1"]
    }
    step {
      id = "3"
      name = "gcr.io/cloud-builders/git"
      entrypoint = "bash"
      args = [
        "-c",
        "cd ${google_sourcerepo_repository.repository.name} && git config user.email \"none@xascode.dev\" && git config user.name \"none\""
      ]
      timeout = "30s"
      wait_for = ["2"]
    }
    step {
      id = "4"
      name = "gcr.io/cloud-builders/git"
      entrypoint = "bash"
      args = [
        "-c",
        "cd ${google_sourcerepo_repository.repository.name} && git merge upstream/${var.environment} --allow-unrelated-histories"
      ]
      timeout = "30s"
      wait_for = ["3"]
    }
    step {
      id = "5"
      name = "gcr.io/cloud-builders/git"
      entrypoint = "bash"
      args = [
        "-c",
        "cd ${google_sourcerepo_repository.repository.name} && git push origin ${var.environment}"
      ]
      timeout = "30s"
      wait_for = ["4"]
    }
  }

  depends_on = [ google_project_service.cloud_build ]
}
