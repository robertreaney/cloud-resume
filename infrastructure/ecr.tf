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

# build images
# resource "docker_image" "website" {
#   name     = "${aws_ecr_repository.cloud-resume.repository_url}:latest"
#   platform = "linux"

#   build {
#     context = "../services/website"
#     tag     = ["${aws_ecr_repository.cloud-resume.repository_url}:latest"]
#   }

#   triggers = {
#     dir_sha1 = sha1(join("", [for f in fileset(path.module, "../services/website/*") : filesha1(f) if !(f == "../services/website/__pycache__" || f == "../services/website/recording.wav")]))
#   }
# }

# push image
# resource "docker_registry_image" "website" {
#   name = docker_image.website.name
#   triggers = {
#     dir_sha1 = sha1(join("", [for f in fileset(path.module, "../services/website/*") : filesha1(f) if !(f == "../services/website/__pycache__" || f == "../services/website/recording.wav")]))
#   }
# }