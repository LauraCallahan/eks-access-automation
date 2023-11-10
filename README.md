# AWS EKS Access Script

This script automates the process of configuring AWS credentials and assuming a specific IAM role for accessing an Amazon EKS (Elastic Kubernetes Service) cluster. It reads credentials and other necessary configurations from an `.env` file and sets them up for your session.

## Prerequisites

- AWS CLI: Ensure that the AWS Command Line Interface is installed on your system.
- Kubernetes Command Line Tool (kubectl): Required for interacting with your EKS cluster.
- Access to an AWS account with permissions to assume an IAM role and access EKS.

## Setup

1. **Clone the Repository**
   - Clone this repository to your local machine or download the script file directly.

2. **Create the .env File**
   - In the same directory as the script, create a file named `.env`.
   - Add your AWS credentials and configurations to the `.env` file in the following format:
     ```
     AWS_ACCESS_KEY_ID=your_access_key
     AWS_SECRET_ACCESS_KEY=your_secret_key
     AWS_REGION=your_region
     AWS_OUTPUT=your_default_format
     ROLE_ARN=your_role_arn
     ```
   - Replace each placeholder with your actual details.

3. **Update .gitignore (Optional but Recommended)**
   - To prevent accidentally committing sensitive information, add `.env` to your `.gitignore` file.

4. **Make the Script Executable**
   - Run the following command to make the script executable:
     ```bash
     chmod +x eks_access.sh
     ```

## Usage

1. **Source the Script**
   - Run the script with the following command:
     ```bash
     source ./eks_access.sh
     ```
   - This will execute the script in the current shell, allowing the environment variables to be set properly.

2. **Verify Credentials (Optional)**
   - To verify if the credentials are set correctly, you can use:
     ```bash
     echo $AWS_ACCESS_KEY_ID
     echo $AWS_SECRET_ACCESS_KEY
     echo $AWS_SESSION_TOKEN
     ```
   - Remember, for security reasons, it's best not to leave these commands in your shell history.

3. **Interact with Your EKS Cluster**
   - After sourcing the script, you can use `kubectl` to interact with your EKS cluster.

## Important Notes

- **Security**: Never commit the `.env` file with your AWS credentials to a public repository. Always keep such files local or in a secure, private location.
- **Scope**: The environment variables set by the script are only available in the current shell session. If you open a new terminal or session, you'll need to source the script again.
- **Troubleshooting**: If you encounter any issues, ensure that the AWS CLI is configured correctly, and you have the necessary permissions in AWS to perform the actions.
