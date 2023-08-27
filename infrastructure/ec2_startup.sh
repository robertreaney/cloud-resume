#!/bin/bash
# setup
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
# docker official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# setup repo
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# update apt-get
sudo apt-get update
# install docker engine
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# install aws cli
sudo apt-get install -y awscli

# configure aws credentials
# Replace these variables with your values
# DEFAULT_REGION="us-east-1"
# DEFAULT_OUTPUT="json"

# # Create ~/.aws directory if it doesn't exist
# mkdir -p ~/.aws

# # Configure AWS credentials
# cat > ~/.aws/credentials << EOL
# [default]
# aws_access_key_id = ${AWS_ACCESS_KEY_ID}
# aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
# EOL

# # Configure AWS default region and output
# cat > ~/.aws/config << EOL
# [default]
# region = ${DEFAULT_REGION}
# output = ${DEFAULT_OUTPUT}
# EOL

# authenticate docker to ecr
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
aws ecr get-login-password --region us-east-1 | sudo docker login -u AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com

# pull the website image
sudo docker pull DOCKER_IMAGE_NAME

# start the application
sudo docker run -d -p 80:5000 DOCKER_IMAGE_NAME