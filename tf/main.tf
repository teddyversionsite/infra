terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }

  backend "gcs" {
    bucket = "teddyversion-tf-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "teddyversion"
  region  = "us-east4"
  zone    = "us-east4-c"
}

