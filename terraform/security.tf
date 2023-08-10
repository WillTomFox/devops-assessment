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