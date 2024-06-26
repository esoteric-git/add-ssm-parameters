# AWS SSM Parameter Store Uploader

This project provides a simple script for adding parameters to AWS Systems Manager (SSM) Parameter Store. It's designed to work in conjunction with the [tweet-pipeline](https://github.com/esoteric-git/tweet-pipeline) repository, allowing you to securely store your secrets and configuration values in AWS Parameter Store.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [IAM Setup](#iam-setup)
3. [Installation](#installation)
4. [Usage](#usage)
5. [File Structure](#file-structure)
6. [License](#license)

## Prerequisites

Before using this script, ensure you have the following:

1. An AWS account
2. AWS CLI installed and configured
3. jq (command-line JSON processor) installed
4. Bash shell environment

## IAM Setup

To use this script, you need to set up the appropriate IAM permissions in AWS:

1. Create an IAM user or role with the following permissions:
   - `ssm:PutParameter`
   - `ssm:GetParameter` (optional, for verification)

2. Attach a policy to the IAM user or role with the following JSON:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:PutParameter",
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:*:*:parameter/*"
        }
    ]
}
```

3. If using an IAM user, create access keys and configure the AWS CLI with these credentials.

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/esoteric-git/aws-ssm-parameter-uploader.git
   cd aws-ssm-parameter-uploader
   ```

2. Ensure the script is executable:
   ```
   chmod +x add_parameters.sh
   ```

## Usage

1. Edit the `add_parameters.json` file to include the parameters you want to add to SSM Parameter Store. Follow this format:

```json
[
    {
      "Name": "/your/parameter/path",
      "Value": "your_parameter_value",
      "Type": "SecureString"
    }
]
```

2. Run the script:
   ```
   ./add_parameters.sh
   ```

3. The script will iterate through each parameter in the JSON file and add it to SSM Parameter Store.

## File Structure

- `add_parameters.sh`: The main script that reads the JSON file and uploads parameters to SSM.
- `add_parameters.json`: JSON file containing the parameters to be uploaded.

## License

This project is licensed under the [MIT License](LICENSE).
