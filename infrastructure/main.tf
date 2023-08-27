terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.1"
    }

    docker = {
      source = "kreuzwerker/docker"
    }
  }

  backend "s3" {
    bucket = "reaney-terraform-states"
    key    = "cloud-resume"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
  registry_auth {
    address  = "https://${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com"
    username = "AWS"
    password = data.aws_ecr_authorization_token.current.password
  }
}
