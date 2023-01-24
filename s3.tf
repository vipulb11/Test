provider "aws" {
    region     = "ap-south-1"
    access_key = ""
    secret_key = ""
  }

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-bucket-5643"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}
