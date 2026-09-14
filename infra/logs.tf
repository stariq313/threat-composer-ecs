resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/ecsv1-threatmod"
  retention_in_days = 7

  tags = {
    Name        = "ecsv1-threatmod-logs"
    Project     = "ecs-v1"
    Environment = "dev"
  }
}

