###############################################################################
# Terraform and Providers blocks
###############################################################################
provider "aws" {
  region              = var.region
  allowed_account_ids = [var.aws_account_id]
}

terraform {
  required_version = ">= 1.0.2"
  required_providers {
    aws = {
      version = "~> 3.41.0"
    }
  }
  backend "s3" {
    bucket  = "XXXXXXXXXXXXX-build-state-bucket-cicd"
    key     = "terraform.200artifactory.tfstate"
    region  = "XXXXXXXXXXXXX"
    encrypt = "true"
  }
}

###############################################################################
# Terraform Remote State (000base)
###############################################################################
data "terraform_remote_state" "_000base" {
  backend = "s3"

  config = {
    bucket  = "130541009828-build-state-bucket-cicd"
    key     = "terraform.000base.tfstate"
    region  = "ap-southeast-2"
    encrypt = "true"
  }
}

###############################################################################
# Data Sources and Locals
###############################################################################
locals {
  vpc_id     = data.terraform_remote_state._000base.outputs.vpc_id
  subnet_az1 = data.terraform_remote_state._000base.outputs.subnet_az1
  subnet_az2 = data.terraform_remote_state._000base.outputs.subnet_az2
  subnet_az3 = data.terraform_remote_state._000base.outputs.subnet_az3
}

###############################################################################
# Security Groups - EC2 (Jenkins)
###############################################################################
resource "aws_security_group" "artifactory_security_group" {
  vpc_id      = local.vpc_id
  name_prefix = "artifactory-sg-"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.source_address]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.source_address]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = [var.source_address]
  }

  ingress {
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = [var.source_address]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [var.source_address]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "all-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

###############################################################################
# EC2 - Amazon Linux 2 (Artifactory)
###############################################################################
resource "aws_instance" "artifactory" {
  ami              = var.ami_centos
  instance_type    = var.instance_type
  subnet_id        = local.subnet_az1
  security_groups  = [aws_security_group.artifactory_security_group.id]
  key_name         = var.key_name
  user_data_base64 = base64encode(var.user_data)

  tags = {
    Name = "Artifactory"
  }
}
