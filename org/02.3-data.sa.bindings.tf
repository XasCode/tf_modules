// Billing Account User
resource "google_organization_iam_binding" "sa_billing_account_user" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/billing.user"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// Compute Image User
resource "google_organization_iam_binding" "sa_compute_image_user" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/compute.imageUser"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// Compute Instance Admin (v1)
resource "google_organization_iam_binding" "sa_compute_instance_admin_v1" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/compute.instanceAdmin.v1"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// Compute Network Admin
resource "google_organization_iam_binding" "sa_compute_network_admin" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/compute.networkAdmin"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// Compute Shared VPC Admin
resource "google_organization_iam_binding" "sa_compute_shared_vpc_admin" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/compute.xpnAdmin"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// DNS Administrator
resource "google_organization_iam_binding" "sa_dns_administrator" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/dns.admin"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// Folder Admin
resource "google_organization_iam_binding" "sa_folder_admin" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/resourcemanager.folderAdmin"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// Folder Creator
resource "google_organization_iam_binding" "sa_folder_creator" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/resourcemanager.folderCreator"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// Organization Role Administrator
resource "google_organization_iam_binding" "sa_organization_role_administrator" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/iam.organizationRoleAdmin"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// Organization Viewer
resource "google_organization_iam_binding" "sa_organization_viewer" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/resourcemanager.organizationViewer"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// TODO:group:argadmins@xascode.dev was commented out.
// Project Creator
resource "google_organization_iam_binding" "sa_project_creator" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/resourcemanager.projectCreator"
  members = [
    "group:orgadmins@xascode.dev",
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// Project IAM Admin
resource "google_organization_iam_binding" "sa_project_iam_admin" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/resourcemanager.projectIamAdmin"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// Security Admin
resource "google_organization_iam_binding" "sa_security_admin" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/iam.securityAdmin"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}

// Service Usage Admin
resource "google_organization_iam_binding" "serviceusage_admin" {
  count   = var.environment == "main"  ? 1 : 0
  org_id  = var.organization_id
  role    = "roles/serviceusage.serviceUsageAdmin"
  members = [
    "serviceAccount:${google_service_account.service_account[0].email}"
  ]
}
