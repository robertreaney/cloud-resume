output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.cloud-resume.repository_url
}

output "website_server" {
  description = "public ip4"
  value       = aws_instance.website_server.public_ip
}