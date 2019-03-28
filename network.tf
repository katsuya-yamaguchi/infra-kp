####################
# EIP
####################
resource "aws_eip" "eip" {
  vpc = true
  instance = "${aws_instance.bastion.id}"
}

####################
# Internet GW
####################
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.kp-network.id}"
}

####################
# VPC
####################
resource "aws_vpc" "kp-network" {
  enable_dns_support = "false"
  cidr_block         = "${lookup(var.vpc, "${terraform.workspace}.cidr", "0.0.0.0/16")}"
  tags = {
    Name = "kp-networks"
  }
}

####################
# Subnet
####################
resource "aws_subnet" "public-a" {
  vpc_id = "${aws_vpc.kp-network.id}"
  availability_zone = "us-east-2a"
  cidr_block         = "${lookup(var.subnet_public-a, "${terraform.workspace}.cidr", "0.0.0.0/16")}"
  tags = {
    Name = "public-a"
  }
}

resource "aws_subnet" "public-b" {
  vpc_id = "${aws_vpc.kp-network.id}"
  availability_zone = "us-east-2b"
  cidr_block         = "${lookup(var.subnet_public-b, "${terraform.workspace}.cidr", "0.0.0.0/16")}"
  tags = {
    Name = "public-b"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id = "${aws_vpc.kp-network.id}"
  availability_zone = "us-east-2a"
  cidr_block         = "${lookup(var.subnet_private-a, "${terraform.workspace}.cidr", "0.0.0.0/16")}"
  tags = {
    Name = "private-a"
  }
}

resource "aws_subnet" "private-b" {
  vpc_id = "${aws_vpc.kp-network.id}"
  availability_zone = "us-east-2b"
  cidr_block         = "${lookup(var.subnet_private-b, "${terraform.workspace}.cidr", "0.0.0.0/16")}"
  tags = {
    Name = "private-b"
  }
}

resource "aws_subnet" "database-a" {
  vpc_id = "${aws_vpc.kp-network.id}"
  availability_zone = "us-east-2a"
  cidr_block         = "${lookup(var.subnet_database-a, "${terraform.workspace}.cidr", "0.0.0.0/16")}"
  tags = {
    Name = "database-a"
  }
}

resource "aws_subnet" "database-b" {
  vpc_id = "${aws_vpc.kp-network.id}"
  availability_zone = "us-east-2b"
  cidr_block         = "${lookup(var.subnet_database-b, "${terraform.workspace}.cidr", "0.0.0.0/16")}"
  tags = {
    Name = "database-b"
  }
}

####################
# Routing
####################
resource "aws_route_table" "to_internet" {
  vpc_id = "${aws_vpc.kp-network.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}

resource "aws_route_table_association" "public-a" {
  subnet_id = "${aws_subnet.public-a.id}"
  route_table_id = "${aws_route_table.to_internet.id}"
}
