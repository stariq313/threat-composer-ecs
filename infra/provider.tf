terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}



resource "aws_ecs_cluster" "main" {
  name = "ecsv1-cluster"

  tags = {
    Name        = "ecsv1-cluster"
    Project     = "ecs-v1"
    Environment = "dev"
  }
}

resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/ecsv1-threatmod"
  retention_in_days = 7

  tags = {
    Name        = "ecsv1-threatmod-logs"
    Project     = "ecs-v1"
    Environment = "dev"
  }
}

data "aws_iam_policy_document" "ecs_task_execution_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsv1-task-execution-role"

  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role.json

  tags = {
    Name        = "ecsv1-task-execution-role"
    Project     = "ecs-v1"
    Environment = "dev"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "ecsv1-threatmod"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "threatmod"
      image     = "578254122438.dkr.ecr.eu-west-2.amazonaws.com/ecsv1-threatmod:v1-8080"
      essential = true

      portMappings = [
        {
          containerPort = 8080
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-region        = "eu-west-2"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = {
    Name        = "ecsv1-threatmod-task"
    Project     = "ecs-v1"
    Environment = "dev"
  }
}
