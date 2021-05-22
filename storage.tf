resource "google_storage_bucket" "static_site" {
  name          = var.bucket_name
  location      = "ASIA-SOUTHEAST2"
  storage_class = "STANDARD"
  force_destroy = true

  website {
    main_page_suffix = "index.html"
  }
}

resource "google_storage_bucket_access_control" "static_site_public" {
  bucket     = google_storage_bucket.static_site.name
  role       = "READER"
  entity     = "allUsers"
  depends_on = [
    google_storage_bucket_iam_policy.bucket_iam_policy
  ]
}

data "google_iam_policy" "static_site_viewer" {
  binding {
    role = "roles/storage.objectViewer"
    members = [
      "allUsers",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "static_site_iam_policy" {
  bucket      = google_storage_bucket.static_site.name
  policy_data = data.google_iam_policy.static_site_viewer.policy_data
}
