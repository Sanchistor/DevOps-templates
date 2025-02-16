resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.app_name}-cluster"
  tags = {
    Environment = var.tag-name
  }
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "${var.app_name}-task"

  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.app_name}-container",
      "image": "${var.ecr_image}",
      "entryPoint": [],
      "essential": true,
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.log-group.id}",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "${var.app_name}"
        }
      },
      "portMappings": [
        {
          "containerPort": 8080,
          "protocol": "tcp"
        }
      ],
      "cpu": 256,
      "memory": 512
    }
  ]
  DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  task_role_arn            = var.ecs_role # for pulling the container image from ECR and writing logs to CloudWatch.
  execution_role_arn       = var.ecs_role # for any permissions your application requires (e.g., S3, RDS access).

  tags = {
    Environment = var.tag-name
  }
}


resource "aws_ecs_service" "ecs-service" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.aws-ecs-task.arn
  desired_count   = 1

  launch_type = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids                      # Specify the subnets for your ECS tasks
    security_groups  = [aws_security_group.ecs_service.id] # Use a security group for your service
    assign_public_ip = true                                # Set to false if you're not using a public subnet
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn # Attach to an Application Load Balancer
    container_name   = "${var.app_name}-container"
    container_port   = 8080
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  tags = {
    Environment = var.tag-name
  }
}
