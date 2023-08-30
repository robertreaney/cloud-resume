output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.cloud-resume.repository_url
}

output "docker_image" {
  description = "Website docker image name."
  value       = docker_registry_image.website.name
}

output "nginx_image" {
  description = "Nginx docker image name."
  value       = docker_registry_image.nginx.name
}

output "website_server" {
  description = "public ip4"
  value       = aws_eip.website_server.public_ip
}