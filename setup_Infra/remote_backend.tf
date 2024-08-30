terraform {
  backend "s3" {
    bucket         = "project1-remote-backend-terraform"
    key            = "terrafrom_project1/terraform.tfstate"
    dynamodb_table = "project1-remote-backend-table"
    encrypt        = true
    region         = "ap-south-1" // Terraform does not support using variables directly in the backend configuration.
  }
}