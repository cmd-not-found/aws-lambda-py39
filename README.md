# aws-lambda-py39
GitHub Action to make zip deployment to AWS Lambda with requirements in a separate layer using Python 3.9.

This is a modified versioned of action published here:

[![GitHubActions](https://img.shields.io/badge/listed%20on-GitHubActions-blue.svg)](https://github.com/marketplace/actions/aws-lambda-zip-deploy-python)

## Description
This action automatically installs requirements, zips and deploys the code including the dependencies as a separate layer.

#### Python 3.9 is supported

### Pre-requisites
In order for the Action to have access to the code, you must use the `actions/checkout@main` job before it. 

### Structure
- Lambda code should be `lambda_function.py`** unless you want to have a customized file name.

### Environment variables
Storing credentials as secret is strongly recommended. 

- **AWS Credentials**  
    `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `REGION` are required.

### Inputs
- `lambda_region`  
- `lambda_function_name`  
    The Lambda function name. [From the AWS docs](https://docs.aws.amazon.com/cli/latest/reference/lambda/update-function-code.html), it can be any of the following:
    - Function name - `function-name`  
    - Function ARN - `arn:aws:lambda:us-west-2:123456789012:function:function-name`  
    - Partial ARN - `123456789012:function:function-name`

### Example Workflow
```yaml
on:
  push:
    branches:
      - master
jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@main
    - name: Deploy code to Lambda
      uses: cmd-not-found/aws-lambda-py39@v1.0
      with:
        lambda_function_name: ${{ secrets.LAMBDA_FUNCTION_NAME }}
        lambda_region: 'eu-central-1'

      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```
