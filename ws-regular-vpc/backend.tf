terraform {
  backend "gcs" {
    bucket = "4678-chime0501-cse1-edhmd111"
    prefix = "terraform/state/ws-regular-vpc"
  }
}
