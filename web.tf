resource "aws_instance" "web" {
  ami                         = "ami-08718895af4dfa033"
  instance_type               = "t2.micro"
  key_name                    = "mannu"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public[0].id
  vpc_security_group_ids      = [aws_security_group.web.id]

}