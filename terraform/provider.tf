terraform {
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "lab6-tf-state"
    key = "terraform.tfstate"
    dynamodb_table = "lab6-tfstate=lockid"
    region     = "us-east-1"
  }
}

# Configure the AWS provider
provider "aws" {
  region     = "us-east-1"
}
