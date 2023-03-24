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

resource "github_branch_protection" "infra" {
  repository_id = github_repository.infra.name

  pattern        = "main"
  enforce_admins = true

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    require_code_owner_reviews = true
    pull_request_bypassers = [
      "/tylerrasor"
    ]
  }
}

resource "github_branch_protection" "teddyversion-frontend" {
  repository_id = github_repository.teddyversion-frontend.name

  pattern        = "main"
  enforce_admins = true

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    require_code_owner_reviews = true
    pull_request_bypassers = [
      "/tylerrasor"
    ]
  }
}
