/*
 * The notification to send when the contents of a watched bucket changes.
 */
 
resource "google_pubsub_topic" "topic" {
  project = var.projects.repo.project_id
  name = "${var.tf_org}_${var.managed.id}_${var.environment}_source_bucket_notification_topic"
}
