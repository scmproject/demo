# demo
Create a docker based application and this application should able to upload files to s3 (A simple page is fine) . Application should be access using a domain name . Try to setup this using Cloudformation/Terraform atleast the infrastructre part.  

You can use the CloudFormation template to create the S3 bucket by running the following AWS CLI command:
# aws cloudformation create-stack --stack-name my-s3-stack --template-body file://s3-bucket.yaml

# Using Terraform:

Create a Terraform configuration file (e.g., s3-bucket.tf) with the following content:

# terraform init

# terraform apply

Here's an example of a Dockerfile that includes the necessary dependencies







