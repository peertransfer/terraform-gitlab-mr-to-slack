terraform {
  required_version = ">= 0.13.1"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.1"
    }
  }
}