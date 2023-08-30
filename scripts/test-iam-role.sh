#!/bin/bash
# started this script to give me a way to test running commands under different assumed IAM roles for debugging purposes

# Variables
IAM_ARN="arn:aws:iam::123456789012:role/YourRoleName"
SESSION_NAME="TestSession"
REGION="us-east-1"

# either set a script path or paste commands. whichever isn't an empty string will be run.
SCRIPT_TO_TEST=""
COMMANDS_TO_RUN="
ECR_PASSWORD=\$(aws ecr get-login-password --region $REGION)
echo \$ECR_PASSWORD | docker login --username AWS --password-stdin 123456789012.dkr.ecr.$REGION.amazonaws.com
"

# Store original AWS environment variables to revert back later
ORIGINAL_AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ORIGINAL_AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ORIGINAL_AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN

# Assume the role and capture temporary credentials
temp_role=$(aws sts assume-role \
                    --role-arn $IAM_ARN \
                    --role-session-name $SESSION_NAME \
                    --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' \
                    --output text)

# Check for errors in assume-role command
if [ $? -ne 0 ]; then
  echo "Failed to assume role"
  exit 1
fi

# Extract the individual session variables from the output
AWS_ACCESS_KEY_ID=$(echo $temp_role | awk '{print $1}')
AWS_SECRET_ACCESS_KEY=$(echo $temp_role | awk '{print $2}')
AWS_SESSION_TOKEN=$(echo $temp_role | awk '{print $3}')

# Export the variables into the current environment
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_SESSION_TOKEN

# Run your test commands here
# For example, fetching an ECR login password and logging into Docker

# PUT YOUR COMMAND HERE
if [[ -z "$SCRIPT_TO_TEST" ]]; then
  eval "$COMMANDS_TO_RUN"
else
  source "$SCRIPT_TO_TEST"
fi

# Revert to original state
export AWS_ACCESS_KEY_ID=$ORIGINAL_AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$ORIGINAL_AWS_SECRET_ACCESS_KEY
export AWS_SESSION_TOKEN=$ORIGINAL_AWS_SESSION_TOKEN

# Clear session-specific environment variables to avoid potential future conflicts
unset temp_role
unset ORIGINAL_AWS_ACCESS_KEY_ID
unset ORIGINAL_AWS_SECRET_ACCESS_KEY
unset ORIGINAL_AWS_SESSION_TOKEN
