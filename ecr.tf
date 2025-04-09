# ECR Repository for the Task Listing app
resource "aws_ecr_repository" "task_listing_app" {
  name                 = "task-listing-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Output the repository URL so we can use it in our CI/CD pipeline
output "repository_url" {
  value = aws_ecr_repository.task_listing_app.repository_url
  description = "The URL of the ECR repository"
}