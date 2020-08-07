resource "google_compute_global_address" "gcs-static-site-ip" {
  name = "global-gcs-static-site-ip"
}

data "google_compute_global_address" "gcs-static-site-ip" {
  name = "global-gcs-static-site-ip"
}

resource "google_compute_global_forwarding_rule" "gcs-static-site-forwarding" {
  name       = "global-rule"
  target     = google_compute_target_https_proxy.gcs-static-site-frontend.id
  port_range = "443"
  ip_address = data.google_compute_global_address.gcs-static-site-ip.address
}

resource "google_compute_target_https_proxy" "gcs-static-site-frontend" {
  name             = "gcs-static-site-frontend"
  provider         = google-beta
  url_map          = google_compute_url_map.gcs-static-site-urlmap.id
  ssl_certificates = [google_compute_managed_ssl_certificate.gcs-static-site-cert.id]
}

resource "google_compute_global_forwarding_rule" "gcs-static-site-forwarding-http" {
  name       = "global-rule-http"
  target     = google_compute_target_http_proxy.gcs-static-site-frontend-http.id
  port_range = "80"
  ip_address = data.google_compute_global_address.gcs-static-site-ip.address
}

resource "google_compute_target_http_proxy" "gcs-static-site-frontend-http" {
  name     = "gcs-static-site-frontend-http"
  provider = google-beta
  url_map  = google_compute_url_map.gcs-static-site-urlmap.id
}

resource "google_compute_backend_bucket" "gcs-static-site-backend-bucket" {
  name        = "gcs-static-site-backend-bucket"
  description = "Bucket for gcs-static-site - ${var.domain_name}"
  bucket_name = google_storage_bucket.gcs-static-site-resources.name
  enable_cdn  = true
}

resource "google_compute_url_map" "gcs-static-site-urlmap" {
  name        = "gcs-static-site-urlmap"
  description = "URL mapping for gcs-static-site - ${var.domain_name}"

  default_service = google_compute_backend_bucket.gcs-static-site-backend-bucket.id

  host_rule {
    hosts        = [var.domain_name, "www.${var.domain_name}"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_bucket.gcs-static-site-backend-bucket.id

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_bucket.gcs-static-site-backend-bucket.id
    }
  }
}
