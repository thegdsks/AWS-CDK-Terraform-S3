# Provider Configuration
provider "aws" {
  region = "us-east-1" # Feel free to change this to your preferred AWS region
}

# S3 Bucket Resource for Website Hosting
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-12345" # Ensure this bucket name is globally unique
  acl    = "public-read"                 # Public read access

  website {
    index_document = "index.html"
  }
}

# S3 Bucket Policy for Public Website Access
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "s3:GetObject",
        Effect    = "Allow",
        Principal = "*",
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
      },
    ]
  })
}
