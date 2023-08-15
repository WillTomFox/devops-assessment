data "aws_vpc" "devops_assessment_vpc" {
  id = var.vpc_id
}

resource "aws_subnet" "devops_assessment_subnet" {
  vpc_id                  = data.aws_vpc.devops_assessment_vpc.id
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = true
  # tags = {
  #   Name        = "${var.environment}-${element(var.availability_zones, count.index)}-      public-subnet"
  #   Environment = "${var.environment}"
  # }
}