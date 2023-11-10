#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
    export $(cat .env | xargs)
fi

# Configure AWS credentials
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws configure set default.region "$AWS_REGION"
aws configure set default.output "$AWS_OUTPUT"

# Assume the specified role using AWS STS
session_name="kube-session"

# Call assume-role and parse the returned JSON to get the credentials
credentials=$(aws sts assume-role --role-arn "$ROLE_ARN" --role-session-name "$session_name" --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' --output text)

# Check if the credentials were obtained successfully
if [ $? -eq 0 ]; then
    # Extract each credential
    aws_access_key_id=$(echo $credentials | awk '{print $1}')
    aws_secret_access_key=$(echo $credentials | awk '{print $2}')
    aws_session_token=$(echo $credentials | awk '{print $3}')

    # Export credentials as environment variables
    export AWS_ACCESS_KEY_ID=$aws_access_key_id
    export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
    export AWS_SESSION_TOKEN=$aws_session_token

    echo "AWS credentials set successfully."
else
    echo "Failed to assume role."
    exit 1
fi
