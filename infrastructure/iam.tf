# Define the IAM role
resource "aws_iam_role" "ec2_s3_access_role" {
  name = "EC2S3AccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

# Define the IAM policy that allows access to S3 (for example purposes)
resource "aws_iam_policy" "ec2_ecr_s3_access_policy" {
  name        = "EC2ECRS3AccessPolicy"
  description = "My policy that grants access to ECR and S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "s3:*",
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Effect   = "Allow",
        Resource = aws_ecr_repository.cloud-resume.arn
      },
      {
        Action   = "ecr:GetAuthorizationToken",
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })

  depends_on = [aws_ecr_repository.cloud-resume]
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "ec2_s3_attach" {
  policy_arn = aws_iam_policy.ec2_ecr_s3_access_policy.arn
  role       = aws_iam_role.ec2_s3_access_role.name
}

# Create the EC2 instance profile
resource "aws_iam_instance_profile" "ec2_s3_instance_profile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.ec2_s3_access_role.name
}