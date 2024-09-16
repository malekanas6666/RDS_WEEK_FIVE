terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
/*
# object_lock_diabled
//////////////////////////////////////////////
*/
resource "aws_s3_bucket" "bucket_week_five" {
  bucket = "my-bucket-627"
  tags = {
    Name = "terraformChamps"
    Owner="Malek"
  }
}
