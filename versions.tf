terraform {
  required_version = ">= 1.4.0"

  required_providers {
    tfe = {
      version = "~> 0.45.0"
      source  = "hashicorp/tfe"
    }
  }
}