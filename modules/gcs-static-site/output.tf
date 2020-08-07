output "LoadBalancer-IP" {
  value       = data.google_compute_global_address.gcs-static-site-ip.address
  description = "The IP assigned to this load balancer"
}
#output "gcs-static-site-dnssec" {
#  description = "DS digest record for the domain"
#  value       = data.google_dns_keys.gcs-static-site-dnssec-key.key_signing_keys[0].ds_record
#}
