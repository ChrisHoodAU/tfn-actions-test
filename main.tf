provider "aws" {
  version = "~> 2.0"
  region  = "ap-southeast-2"
}

terraform {
  backend "s3" {
    bucket = "chood-20220919-terraform-state"
    key    = "default-infrastructure"
    region = "ap-southeast-2"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "chood-20220919-terraform-state"

  versioning {
    enabled = true
  }
}