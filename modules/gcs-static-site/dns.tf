resource "google_dns_managed_zone" "gcs-static-site-zone" {
  name     = "gcs-static-site-domain"
  dns_name = "${var.domain_name}."

  dnssec_config {
    kind          = "dns#managedZoneDnsSecConfig"
    non_existence = "nsec3"
    state         = "on" # UPDATE 

    default_key_specs {
      algorithm  = "rsasha256"
      key_length = 2048
      key_type   = "keySigning"
      kind       = "dns#dnsKeySpec"
    }
    default_key_specs {
      algorithm  = "rsasha256"
      key_length = 1024
      key_type   = "zoneSigning"
      kind       = "dns#dnsKeySpec"
    }
  }
}

resource "google_dns_record_set" "gcs-static-site-a" {
  name = google_dns_managed_zone.gcs-static-site-zone.dns_name
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.gcs-static-site-zone.name

  rrdatas = [google_compute_global_forwarding_rule.gcs-static-site-forwarding.ip_address]
}

resource "google_dns_record_set" "gcs-static-site-www" {
  name = "www.${google_dns_managed_zone.gcs-static-site-zone.dns_name}"
  type = "CNAME"
  ttl  = 300

  managed_zone = google_dns_managed_zone.gcs-static-site-zone.name

  rrdatas = [google_dns_managed_zone.gcs-static-site-zone.dns_name]
}

data "google_dns_keys" "gcs-static-site-dnssec-key" {
  managed_zone = google_dns_managed_zone.gcs-static-site-zone.id
}
