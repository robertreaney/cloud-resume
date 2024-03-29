resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public key
}

resource "aws_security_group" "website_server_sg" {
  name        = "website_server_sg"
  description = "Allow traffic for Flask app"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # You might want to limit the CIDR blocks for better security
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "website_server_sg"
  }
}

resource "aws_instance" "website_server" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t3a.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3_instance_profile.name
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.website_server_sg.id]

  # user_data = replace(file("${path.module}/ec2_startup.sh"), "DOCKER_IMAGE_NAME", docker_registry_image.website.name)
  user_data = data.template_file.ec2-startup.rendered

  # depends_on = [docker_registry_image.website, aws_s3_object.docker_compose]

  tags = {
    Name = "WebsiteServer"
  }
}

# create elastic ip address for ec2 instance
resource "aws_eip" "website_server" {
  instance = aws_instance.website_server.id

  tags = {
    Name = "website-server-eip"
  }
}

# route 53 zone
resource "aws_route53_zone" "primary" {
  name = "robertreaney.com"
}

# domain name registration
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.robertreaney.com"
  type    = "A"
  ttl     = 300
  records = [aws_instance.website_server.public_ip]
}

# storage for our instance
resource "aws_s3_bucket" "website_bucket" {
  bucket = "reaney-server-storage"
}