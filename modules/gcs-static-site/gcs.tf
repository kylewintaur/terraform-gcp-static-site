resource "google_storage_bucket" "gcs-static-site-resources" {
  name          = var.domain_name
  location      = var.storage_region
  storage_class = var.storage_class
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    max_age_seconds = 600
    method = [
      "GET",
      "HEAD",
      "PUT",
      "POST",
      "DELETE",
    ]
    origin = [
      "https://${var.domain_name}",
      "https://www.${var.domain_name}",
    ]
    response_header = [
      "*",
    ]
  }


}

resource "google_storage_bucket_access_control" "gcs-static-site-bucket-policy" {
  bucket = google_storage_bucket.gcs-static-site-resources.name
  role   = "READER"
  entity = "allUsers"
}
