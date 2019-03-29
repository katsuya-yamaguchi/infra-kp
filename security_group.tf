resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.kp-network.id}"

  ingress {
    protocol = -1
    self = true
    from_port = 0
    to_port = 0
  }

  egress {
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh" {
  name = "ssh"
  description = "allow ssh connection"
  vpc_id = "${aws_vpc.kp-network.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh_to_bastion" {
  name = "ssh_to_bastion"
  description = "allow ssh connection"
  vpc_id = "${aws_vpc.kp-network.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["10.10.10.0/24"]
  }
}

resource "aws_security_group" "alb" {
  name = "alb"
  description = "alb"
  vpc_id = "${aws_vpc.kp-network.id}"

  ingress {
    from_port = 0
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

