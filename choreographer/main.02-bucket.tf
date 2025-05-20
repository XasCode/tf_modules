/*
 * When code is changed in a github repo branch, TF cloud will upload an archive 
 * file to these buckets as a result of the TF configurations in the repository
 */

resource "google_storage_bucket" "bucket" {
  project = var.projects.repo.project_id
  name = "${var.tf_org}_${var.managed.id}_${var.environment}_source_bucket"
  force_destroy = true
  location = var.region
}
