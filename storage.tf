# storage.tf
resource "aws_s3_bucket" "dockerrun_bucket" {
  bucket = "patsy-task-app-dockerrun-bucket"  
  tags = {
    Name        = "Dockerrun Deployment Bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "dockerrun_versioning" {
  bucket = aws_s3_bucket.dockerrun_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}