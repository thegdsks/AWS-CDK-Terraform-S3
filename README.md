
# Deploying a Static Website on Amazon S3 using Terraform

This guide walks you through deploying a static website on Amazon S3 using Terraform.

## Prerequisites

- AWS Account
- Terraform installed on your machine

## Step 0: Setting Up Your Workspace

1. **Create a Directory**: Open your terminal and run:
   ```shell
   mkdir terraform-s3-website && cd terraform-s3-website
   ```
   
2. **Initialize Terraform**:
   ```shell
   terraform init
   ```

## Step 1: Writing Your Terraform Configuration

1. Create a Terraform configuration file named `main.tf` in your project directory and open it in your text editor.

2. Add the AWS provider and specify your region:
   ```hcl
   provider "aws" {
     region = "us-east-1" # You can choose any region
   }
   ```

3. Define the S3 bucket resource for hosting your website:
   ```hcl
   resource "aws_s3_bucket" "my_bucket" {
     bucket = "my-unique-bucket-name-12345" # Bucket name must be unique
     acl    = "public-read"                 # Makes the bucket publicly readable

     website {
       index_document = "index.html"
     }
   }
   ```

4. Configure the S3 bucket policy for public access:
   ```hcl
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
   ```

## Step 2: Deploying Your Website

1. Apply your Terraform configuration to create the S3 bucket:
   ```shell
   terraform apply
   ```
   Type `yes` when prompted to proceed.

2. Upload your `index.html` file to your S3 bucket using the AWS Management Console or AWS CLI.

3. Access your website via the URL provided by S3, formatted as `http://<your-bucket-name>.s3-website-<region>.amazonaws.com`.

## Conclusion

Congratulations! You've now deployed a static website on Amazon S3 using Terraform. This is a basic setup. Terraform allows for much more customization and complex deployments.

