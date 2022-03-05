#!/bin/bash

configure_aws_credentials(){
	aws configure set aws_access_key_id "${INPUT_AWS_ACCESS_KEY_ID}"
    aws configure set aws_secret_access_key "${INPUT_AWS_SECRET_ACCESS_KEY}"
    aws configure set default.region "${INPUT_LAMBDA_REGION}"
}


publish_function_code(){
	echo "Deploying the code itself..."
	zip -r code.zip . -x \*.git\*
	aws lambda update-function-code --function-name "${INPUT_LAMBDA_FUNCTION_NAME}" --zip-file fileb://code.zip
}

deploy_lambda_function(){
	publish_dependencies_as_layer
	publish_function_code
}

deploy_lambda_function
echo "Each step completed, check the logs if any error occured."