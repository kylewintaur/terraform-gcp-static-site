module "gcs-static-site" {
  source = "./modules/gcs-static-site"

  domain_name    = "yourdomain.com.au"
  dnssec	 = "on"
  storage_region = "ASIA"
  storage_class  = "STANDARD"
}
