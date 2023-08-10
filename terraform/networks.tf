data "aws_vpc" "devops_assessment_vpc" {
  id = "vpc-eb3e4d83"
}

resource "aws_subnet" "devops_assessment_subnet" {
  vpc_id                = data.aws_vpc.devops_assessment_vpc.id
  cidr_block = "172.31.64.0/20"
  # count                   = "${length(var.public_subnets_cidr)}"
  # cidr_block              = "${element(var.public_subnets_cidr,   count.index)}"
  # availability_zone       = "${element(var.availability_zones,   count.index)}"
  map_public_ip_on_launch = true
  # tags = {
  #   Name        = "${var.environment}-${element(var.availability_zones, count.index)}-      public-subnet"
  #   Environment = "${var.environment}"
  # }
}