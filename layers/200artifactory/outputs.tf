###############################################################################
# Outputs - Security Groups
###############################################################################
output "artifactory_sg_id" {
  description = "The ID of the Artifactory EC2 Security Group."
  value       = aws_security_group.artifactory_security_group.id
}
