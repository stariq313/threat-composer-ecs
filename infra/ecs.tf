resource "aws_ecs_cluster" "main" {
  name = "ecsv1-cluster"

  tags = {
    Name        = "ecsv1-cluster"
    Project     = "ecs-v1"
    Environment = "dev"
  }
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
