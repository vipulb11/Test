provider "aws" {
    region     = "ap-south-1"
    access_key = "AKIA52EMFTQ6DCCMFHU7"
    secret_key = "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"
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
