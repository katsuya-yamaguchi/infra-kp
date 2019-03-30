resource "aws_route53_delegation_set" "main" {
  reference_name = "mydns"
}

resource "aws_route53_zone" "primary" {
  name = "${lookup(var.fqdn, "${terraform.workspace}.fqdn", "sample.com")}"
  delegation_set_id = "${aws_route53_delegation_set.main.id}"
}

resource "aws_route53_record" "ns" {
  zone_id = "${aws_route53_zone.primary.id}"
  name = "${lookup(var.fqdn, "${terraform.workspace}.fqdn", "sample.com")}"
  type = "A"
  ttl = "300"
  records = ["${aws_eip.eip.public_ip}"]
}
