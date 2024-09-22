resource "aws_security_group" "web" {
  name        = var.web_security_group.name
  description = var.web_security_group.description
  vpc_id      = aws_vpc.ntier.id
  tags = {
    Name = var.web_security_group.name
  }
  depends_on = [aws_vpc.ntier]

}

#ingress/inbound rules for web

resource "aws_vpc_security_group_ingress_rule" "web" {
    count = length(var.web_security_group.inbound_rules)
    security_group_id = aws_security_group.web.id
    cidr_ipv4 = var.web_security_group.inbound_rules[count.index].source
    ip_protocol = var.web_security_group.inbound_rules[count.index].protocol
    description = var.web_security_group.inbound_rules[count.index].description
    from_port = var.web_security_group.inbound_rules[count.index].port
    to_port = var.web_security_group.inbound_rules[count.index].port
    depends_on = [ aws_security_group.web  ]
}

#egress/outbound rules for web
resource "aws_vpc_security_group_egress_rule" "web" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  depends_on        = [aws_security_group.web]
}

