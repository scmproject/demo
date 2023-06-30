# Define provider and region
provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name" # Replace with your desired bucket name
  acl    = "private"
}

# Create an ALB
resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_sg.id]
  subnets            = ["subnet-12345678", "subnet-23456789"] # Replace with your subnet IDs
}

# Create a security group for the ALB
resource "aws_security_group" "my_sg" {
  name        = "my-security-group"
  description = "Security group for the ALB"
  vpc_id      = "vpc-12345678" # Replace with your VPC ID

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an ECS cluster
resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster"
}

# Create an ECS task definition
resource "aws_ecs_task_definition" "my_task_definition" {
  family                   = "my-task-family"
  execution_role_arn       = aws_iam_role.my_task_execution_role.arn
  task_role_arn            = aws_iam_role.my_task_role.arn
  network_mode             = "awsvpc"

  container_definitions = <<DEFINITION
[
  {
    "name": "my-container",
    "image": "<your-ecr-registry-url>/<your-repository-name>:your-version",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "AWS_ACCESS_KEY_ID",
        "value": "<your-access-key-id>"
      },
      {
        "name": "AWS_SECRET_ACCESS_KEY",
        "value": "<your-secret-access-key>"
      },
      {
        "name": "AWS_DEFAULT_REGION",
        "value": "<your-aws-region>"
      }
    ]
  }
]
DEFINITION
}

# Create an ECS service
resource "aws_ecs_service" "my_service" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = 1

  network_configuration {
    subnets         = ["subnet-12345678", "subnet-23456789"] # Replace with your subnet IDs
    security_groups = [aws_security_group.my_sg.id]
    assign_public_ip = true
  }
}

# Create an A record in Route 53 for the ALB
resource "aws_route53_record" "my_alb_record" {
  zone_id = "my-zone-id"
