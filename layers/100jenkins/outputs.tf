###############################################################################
# Outputs - Security Groups
###############################################################################
output "jenkins_sg_id" {
  description = "The ID of the Jenkins EC2 Security Group."
  value       = aws_security_group.jenkins_security_group.id
}
