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

resource "aws_security_group" "test_sg" {
  name        = "cjhood_testsg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["172.31.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cjhood_test"
  }
}