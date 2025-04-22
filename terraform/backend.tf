terraform {
  backend "s3" {
    bucket         = "terraform-state-beckup"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
  }
}