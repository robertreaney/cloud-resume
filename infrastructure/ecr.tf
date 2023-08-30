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

# build  website image
resource "docker_image" "website" {
  name     = "${aws_ecr_repository.cloud-resume.repository_url}:latest"
  platform = "linux"

  build {
    context = "../website"
    tag     = ["${aws_ecr_repository.cloud-resume.repository_url}:latest"]
  }

  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "../website/*") : filesha1(f) if !(f == "../website/__pycache__" || f == "../website/recording.wav")]))
  }
}

# push image
resource "docker_registry_image" "website" {
  name = docker_image.website.name
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "../website/*") : filesha1(f) if !(f == "../website/__pycache__" || f == "../website/recording.wav")]))
  }
}

# build nginx image
resource "docker_image" "nginx" {
  name     = "${aws_ecr_repository.cloud-resume.repository_url}:nginx"
  platform = "linux"

  build {
    context = "../services/nginx"
    tag     = ["${aws_ecr_repository.cloud-resume.repository_url}:nginx"]
  }

  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "../services/nginx/*") : filesha1(f)]))
  }
}

# push image
resource "docker_registry_image" "nginx" {
  name = docker_image.nginx.name
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "../services/nginx/*") : filesha1(f)]))
  }
}