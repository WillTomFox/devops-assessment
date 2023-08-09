data "aws_vpc" "devops_assessment_vpc" {
  id = "vpc-089a68f18c73bf566"
}

resource "aws_subnet" "devops_assessment_subnet" {
  vpc_id     = data.aws_vpc.devops_assessment_vpc.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_security_group" "devops_assessment_security_group" {
  name   = "devops-assessment-security-group"
  vpc_id = data.aws_vpc.devops_assessment_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_cluster" "devops_assessment_ecs_cluster" {
  name     = "devops-assessment-ecs-cluster"
}

resource "aws_ecs_task_definition" "devops_assessment_task" {
  family                   = "devops-assessment-task"
  network_mode             = "awsvpc"
  container_definitions    = jsonencode([{
    name  = "devops-assessment"
    image = "303981612052.dkr.ecr.region.amazonaws.com/devops_assessment:latest"
    portMappings = [{
      containerPort = 8080
      protocol      = "tcp"
    }]
  }])
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
}

resource "aws_ecs_service" "devops_assessment_ecs_service" {
  name            = "devops-assessment-ecs-service"
  cluster         = aws_ecs_cluster.devops_assessment_ecs_cluster.arn
  task_definition = aws_ecs_task_definition.devops_assessment_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.devops_assessment_subnet.id]
    security_groups  = [aws_security_group.devops_assessment_security_group.id]
    assign_public_ip = true
  }
}
