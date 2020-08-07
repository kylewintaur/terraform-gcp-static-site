variable "domain_name" {
  type = string
}

variable "dnssec" {
  type = string
  default = "off"
}

variable "storage_region" {
  type = string
}

variable "storage_class" {
  type    = string
  default = "STANDARD"
}
