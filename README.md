# Terraform - GCP Static Hosted Website
This Terraform script creates a static hosted website from Google Cloud Storage, served by Cloud Load Balancers, and secured with a Google SSL Certificate.

If you use this repo as is, you can basically point your domain to the name servers provided in the output, and the Terraform script _should_ set up all A/CNAME/TXT records, install the SSL, configure the CDN, etc.
