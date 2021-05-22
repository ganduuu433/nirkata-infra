resource "google_cloudbuild_trigger" "github_push_trigger" {
  name     = "gcp-source-trigger"
  filename = "cloudbuild.yaml"

  trigger_template {
    branch_name = "master"
    repo_name   = var.gcp_cloud_source_repo
  }
}