resource "aws_instance" "bastion" {
  ami = "ami-02bcbb802e03574ba"
  availability_zone = "us-east-2a"
  instance_type = "${lookup(var.instance_type, "${terraform.workspace}.instance_type", "t2.nano")}"
  subnet_id = "${aws_subnet.public-a.id}"
  vpc_security_group_ids = [
    "${aws_security_group.ssh.id}", 
    "${aws_default_security_group.default.id}"
    ]
  key_name = "${aws_key_pair.auth.key_name}"

  root_block_device = {
    delete_on_termination = true
    volume_size = 10
  }

  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "web-001" {
  ami = "ami-02bcbb802e03574ba"
  availability_zone = "us-east-2a"
  instance_type = "${lookup(var.instance_type, "${terraform.workspace}.instance_type", "t2.nano")}"
  subnet_id = "${aws_subnet.private-a.id}"
  vpc_security_group_ids = [
      "${aws_security_group.ssh_to_bastion.id}", 
      "${aws_default_security_group.default.id}"
    ]
  key_name = "${aws_key_pair.auth.key_name}"

  root_block_device = {
    delete_on_termination = false
    volume_size = 10
  }

  tags = {
    Name = "web-001"
  }
}


resource "aws_key_pair" "auth" {
  key_name = "ssh-key"
  public_key = "${file("./key-pair/web-01.pub")}"
}
