resource "aws_ecr_repository" "cloud-resume" {
  name                 = "cloud-resume"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.cloud-resume.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Remove images older than 1 month"
        selection = {
          tagStatus   = "any"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}