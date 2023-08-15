# Create AWS ECS cluster
resource "aws_ecs_cluster" "devops_assessment_ecs_cluster" {
  name     = "devops-assessment-ecs-cluster"
}

# Create AWS ACS task definition
resource "aws_ecs_task_definition" "devops_assessment_task" {
  family                   = "devops-assessment-task"
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  container_definitions    = jsonencode([{
    name  = "devops-assessment"
    image = "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/devops_assessment:latest"
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
    }]
    log_configuration = {
      log_driver = "awslogs"
      options = {
        awslogs-group         = "ecs-container"
        awslogs-region        = "eu-west-2"
        create-group          = true
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
  requires_compatibilities = ["FARGATE"]
}

# AWS ECS service
resource "aws_ecs_service" "devops_assessment_ecs_service" {
  name            = "devops-assessment-ecs-service"
  cluster         = aws_ecs_cluster.devops_assessment_ecs_cluster.arn
  task_definition = aws_ecs_task_definition.devops_assessment_task.arn
  desired_count   = 3
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.devops_assessment_subnet.id]
    security_groups  = [aws_security_group.devops_assessment_security_group.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.devops_assessment_target_group.arn
    container_name   = "devops-assessment-container"
    container_port   = 8080
  }
}