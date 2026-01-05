output "vpc_id" {
    value = aws_vpc.main.id
}

output "default_vpc_ids" {
   value= data.aws_vpc.default.id
}

output "public_subnet_ids" {
    value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
    value = aws_subnet.private[*].id
}

output "database_subnet_ids" {
    value = aws_subnet.database[*].id
}
