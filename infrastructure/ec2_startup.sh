#!/bin/bash
# setup
touch /startup-test-proof.log
sudo usermod -aG docker ubuntu

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

# authenticate docker to ecr
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
aws ecr get-login-password --region us-east-1 | sudo docker login -u AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com

# pull the website image
sudo docker pull ${DOCKER_IMAGE_NAME}


# start the application
sudo docker run --name website-server -d -p 443:5000 ${DOCKER_IMAGE_NAME}

# sudo docker pull 293245919051.dkr.ecr.us-east-1.amazonaws.com/cloud-resume
# sudo docker run --name website-server -d -p 443:5000 293245919051.dkr.ecr.us-east-1.amazonaws.com/cloud-resume

# save image name for debuggin
echo "export DOCKER_IMAGE_NAME=${DOCKER_IMAGE_NAME}" >> /home/ubuntu/.bashrc