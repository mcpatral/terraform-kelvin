terraform {
  backend "s3" {
    bucket = "terraform-kelvin"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}