
output "vpc_id" {
  value = aws_vpc.ntier.id

}

output "public_subnets_id" {
  value = aws_subnet.public[*].id

}

output "private_subnet_id" {
  value = aws_subnet.private[*].id

}

# web security group
output "web_security_group_id" {
  value = aws_security_group.web.id
}
# web ec2
output "web-ip" {
  value = aws_instance.web.public_ip
}
output "web-insecure-url" {
  value = format("http://%s", aws_instance.web.public_ip)
}
output "web-secure-url" {
  value = "https://${aws_instance.web.public_ip}"
}