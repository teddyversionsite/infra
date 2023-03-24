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

resource "google_storage_bucket" "static-site" {
  name          = "teddyversion.com"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    origin          = ["http://teddyversion.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}
