$AWS_ACCOUNT_ID = (aws sts get-caller-identity --query Account --output text)
# authenticate docker to ecr
$Password = aws ecr get-login-password --region us-east-1
docker login -u AWS --password $Password "$AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com"
