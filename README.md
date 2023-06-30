# demo
Create a docker based application and this application should able to upload files to s3 (A simple page is fine) . Application should be access using a domain name . Try to setup this using Cloudformation/Terraform atleast the infrastructre part.  

You can use the CloudFormation template to create the S3 bucket by running the following AWS CLI command:
# aws cloudformation create-stack --stack-name my-s3-stack --template-body file://s3-bucket.yaml

# Using Terraform:

Create a Terraform configuration file (e.g., s3-bucket.tf) with the following content:

# terraform init

# terraform apply

A sample Dockerfile that includes the necessary dependencies is committed in the repo

Once you have the Dockerfile ready, you can build the Docker image using the docker build command.

# docker build -t myapp:1.0 .

 Once the build process completes, you can verify that the image was created by running:

 # docker images

steps to choose a container registry, create a repository, and push the Docker image:

Create a Repository:
Depending on the chosen container registry, follow the corresponding steps to create a repository. Here, we'll cover creating a repository in Amazon ECR as an example.

    Amazon ECR: If you decide to use Amazon ECR, follow these steps:
        Open the AWS Management Console and navigate to the Amazon ECR service.
        Click on "Repositories" in the left navigation pane.
        Click on the "Create repository" button.
        Provide a name for the repository and configure any desired settings, such as repository permissions or lifecycle policies.
        Click on "Create repository" to create the repository.

    Push the Docker Image:

    # aws ecr get-login-password --region <your-aws-region> | docker login --username AWS --password-stdin <your-ecr-registry-url>

    # docker tag your-image-name:your-version <your-ecr-registry-url>/<your-repository-name>:your-version

    # docker push <your-ecr-registry-url>/<your-repository-name>:your-version

Terraform file is attached to set up the infrastructure using AWS Fargate, an S3 bucket, and an Application Load Balancer (ALB) to access the application using a domain name:








