output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.cloud-resume.repository_url
}

output "docker_image" {
  value = docker_registry_image.website.name
}

output "website_server" {
  value = aws_instance.website_server.public_ip
}