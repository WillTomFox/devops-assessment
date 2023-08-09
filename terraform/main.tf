resource "aws_vpc" "devops_assessment_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "devops_assessment_subnet" {
  vpc_id     = aws_vpc.devops_assessment_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "devops_assessment_security_group" {
  name_prefix = "devops-assessment-security-group"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_task_definition" "devops_assessment_task" {
  family                   = "devops-assessment-task"
  container_definitions    = jsonencode([{
    name  = "devops-assessment"
    image = "devops_assessment:latest"
    portMappings = [{
      containerPort = 443
      protocol      = "tcp"
    }]
  }])
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
}

resource "aws_ecs_service" "devops_assessment_ecs_service" {
  name            = "devops-assessment-ecs-service"
  cluster         = "default"
  task_definition = aws_ecs_task_definition.devops_assessment_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.devops_assessment_subnet.id]
    security_groups  = [aws_security_group.devops_assessment_security_group.id]
    assign_public_ip = true
  }
}
