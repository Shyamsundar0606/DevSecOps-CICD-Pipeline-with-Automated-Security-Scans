# ECS cluster
resource "aws_ecs_cluster" "this" {
  name = "devsecops-demo-cluster"
}

# IAM role for ECS task execution (pull image from ECR, write logs, etc.)
resource "aws_iam_role" "task_execution_role" {
  name = "devsecops-demo-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "task_execution_role_policy" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task definition: describes how to run your container
resource "aws_ecs_task_definition" "app" {
  family                   = "devsecops-demo-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "app"
      image     = "780605918199.dkr.ecr.us-east-1.amazonaws.com/devsecops-demo:latest"
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/devsecops-demo"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

# Log group for the container logs
resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/ecs/devsecops-demo"
  retention_in_days = 7
}

# ECS service: keeps your task running
resource "aws_ecs_service" "app" {
  name            = "devsecops-demo-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = data.aws_subnets.default.ids
    assign_public_ip = true
    security_groups  = [aws_security_group.app_sg.id]
  }

  depends_on = [
    aws_cloudwatch_log_group.app_logs
  ]
}
