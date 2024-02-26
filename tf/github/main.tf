terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.18"
    }
  }

  backend "gcs" {
    bucket = "teddyversion-tf-state"
    prefix = "terraform/state"
  }
}

provider "github" {
  owner = var.org
}

resource "github_repository" "infra" {
  name = "infra"

  visibility = "public"

  template {
    owner                = var.org
    repository           = "infra"
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
    pull_request_bypassers     = [var.tylerrasor]
  }
}

resource "github_repository" "teddyversion-frontend" {
  name = "teddyversion-frontend"

  visibility = "public"

  template {
    owner                = var.org
    repository           = "teddyversion-frontend"
    include_all_branches = true
  }
}

resource "github_branch_protection" "teddyversion-frontend" {
  repository_id = github_repository.teddyversion-frontend.name

  pattern        = "main"
  enforce_admins = true

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    require_code_owner_reviews = true
    pull_request_bypassers     = [var.tylerrasor]
  }

  required_status_checks {
    contexts = [
      "test"
    ]
  }
}

resource "github_repository" "user-service" {
  name = "user-service"

  visibility = "public"

  template {
    owner                = var.org
    repository           = "user-service"
    include_all_branches = true
  }
}

resource "github_branch_protection" "user-service" {
  repository_id = github_repository.user-service.name

  pattern        = "main"
  enforce_admins = true

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    require_code_owner_reviews = true
    pull_request_bypassers     = [var.tylerrasor]
  }
}

resource "github_repository" "music-service" {
  name = "music-service"

  visibility = "public"

  template {
    owner                = var.org
    repository           = "music-service"
    include_all_branches = true
  }
}

resource "github_branch_protection" "music-service" {
  repository_id = github_repository.music-service.name

  pattern        = "main"
  enforce_admins = true

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    require_code_owner_reviews = true
    pull_request_bypassers     = [var.tylerrasor]
  }

  required_status_checks {
    contexts = [
      "dependency-submission",
      "test"
    ]
  }
}
