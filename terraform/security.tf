resource "aws_security_group" "devops_assessment_security_group" {
  name   = "devops-assessment-sg"
  vpc_id = data.aws_vpc.devops_assessment_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outgoing traffic to anywhere
  }
}