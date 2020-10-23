output "nat_gateway_ip" {
  value = aws_eip.nat-gateway-ip.public_ip
}

output "security_groups" {
  value = aws_vpc.main.default_security_group_id
}

output "subnet1" {
  value = aws_subnet.subnet1.id
}

output "subnet2" {
  value = aws_subnet.subnet2.id
}

output "subnet1-private" {
  value = aws_subnet.subnet1-private.id
}

output "subnet2-private" {
  value = aws_subnet.subnet2-private.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}

