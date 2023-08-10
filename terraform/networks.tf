data "aws_vpc" "devops_assessment_vpc" {
  id = "vpc-089a68f18c73bf566"
}

resource "aws_internet_gateway" "main" {
  vpc_id = data.aws_vpc.devops_assessment_vpc.id
}

resource "aws_subnet" "devops_assessment_subnet" {
  vpc_id     = data.aws_vpc.devops_assessment_vpc.id
  cidr_block = "10.0.2.0/24"
}