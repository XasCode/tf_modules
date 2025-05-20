/*
 * Enable notifications by giving the correct IAM permission to the unique service account
 * so that it has the permissions to publish to the topic.
 */

resource "google_pubsub_topic_iam_binding" "binding" {
  project = var.projects.repo.project_id
  topic   = google_pubsub_topic.topic.id
  role    = "roles/pubsub.publisher"
  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}
