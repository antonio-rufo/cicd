###############################################################################
# Outputs - VPC
###############################################################################
output "vpc_id" {
  description = "The ID of the default VPC."
  value       = aws_default_vpc.default.id
}

###############################################################################
# Outputs - Subnets
###############################################################################
output "subnet_az1" {
  description = "The ID of Subnet in AZ1."
  value       = aws_default_subnet.default_az1.id
}

output "subnet_az2" {
  description = "The ID of Subnet in AZ2."
  value       = aws_default_subnet.default_az2.id
}

output "subnet_az3" {
  description = "The ID of Subnet in AZ3."
  value       = aws_default_subnet.default_az3.id
}
