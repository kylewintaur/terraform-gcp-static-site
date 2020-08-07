resource "google_compute_managed_ssl_certificate" "gcs-static-site-cert" {
  name     = "gcs-static-site-cert"
  provider = google-beta
  managed {
    domains = [var.domain_name, "www.${var.domain_name}"]
  }
}
