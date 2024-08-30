terraform {
  backend "s3" {
    bucket         = "project1-remote-backend-terraform"
    key            = "terrafrom_project1/terraform.tfstate"
    dynamodb_table = "project1-remote-backend-table"
    encrypt        = true
    region         = "ap-south-1" // Terraform does not support using variables directly in the backend configuration.
  }
}

# Ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "rb-s3" {
  bucket = "project1-remote-backend-terraform"
    region = var.aws_region
  tags = {
    Environment = "production"
  }
}

# Ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
resource "aws_s3_bucket_versioning" "version-s3" {
  depends_on = [aws_s3_bucket.rb-s3]
  bucket     = aws_s3_bucket.rb-s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Ref.: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
resource "aws_dynamodb_table" "name" {
  name         = "project1-remote-backend-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}