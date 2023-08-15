data "aws_availability_zones" "available" {
}

data "aws_vpc" "devops_assessment_vpc" {
  id = var.vpc_id
}

resource "aws_subnet" "devops_assessment_subnet" {
  count                   = "${length(data.aws_availability_zones.available.names)}"
  vpc_id                  = data.aws_vpc.devops_assessment_vpc.id
  cidr_block              = "${var.cidr_block[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true
  # tags = {
  #   Name        = "${var.environment}-${element(var.availability_zones, count.index)}-      public-subnet"
  #   Environment = "${var.environment}"
  # }
}