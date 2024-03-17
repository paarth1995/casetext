output "vpc_id" {
  value = aws_vpc.test.id
}

output "subnet-1-id" {
  value = aws_subnet.subnet-1.id
}

output "subnet-2-id" {
  value = aws_subnet.subnet-2.id
}

output "sg-id" {
  value = aws_security_group.allow_all.id
}