provider "google" {
  credentials = file("account.json")
  project     = "PROJECT-NAME"
  region      = "australia-southeast1"
  zone        = "australia-southeast1-a"
}

provider "google-beta" {
  credentials = file("account.json")
  project     = "PROJECT-NAME"
  region      = "australia-southeast1"
  zone        = "australia-southeast1-a"
}
