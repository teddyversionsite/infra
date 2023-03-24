terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "teddyversion-tf-state"
    prefix = "terraform/state"
  }
}

provider "github" {
  owner = "teddyversionsite"
}

resource "github_repository" "infra" {
  name = "infra"

  visibility = "public"

  template {
    owner                = "teddyversionsite"
    repository           = "infra"
    include_all_branches = true
  }
}

resource "github_repository" "teddyversion-frontend" {
  name = "teddyversion-frontend"

  visibility = "public"

  template {
    owner                = "teddyversionsite"
    repository           = "teddyversion-frontend"
    include_all_branches = true
  }
}
