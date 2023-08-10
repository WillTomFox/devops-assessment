data "aws_vpc" "devops_assessment_vpc" {
  id = "vpc-089a68f18c73bf566"
}

resource "aws_internet_gateway" "main" {
  vpc_id = data.aws_vpc.devops_assessment_vpc.id
}

resource "aws_subnet" "devops_assessment_subnet" {
  vpc_id                = data.aws_vpc.devops_assessment_vpc.id
  cidr_block = "10.0.2.0/24"
  # count                   = "${length(var.public_subnets_cidr)}"
  # cidr_block              = "${element(var.public_subnets_cidr,   count.index)}"
  # availability_zone       = "${element(var.availability_zones,   count.index)}"
  map_public_ip_on_launch = true
  # tags = {
  #   Name        = "${var.environment}-${element(var.availability_zones, count.index)}-      public-subnet"
  #   Environment = "${var.environment}"
  # }
}