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
    bucket  = "130541009828-build-state-bucket-cicd" ### UPDATE BACKEND BUCKET NAME
    key     = "terraform.000base.tfstate"            ### OPTIONALLY UPDATE KEY, IF YOU LIKE
    region  = "ap-southeast-2"                       ### UPDATE REGION
    encrypt = "true"
  }
}

###############################################################################
# Data Sources
###############################################################################
data "aws_availability_zones" "available" {
  filter {
    name   = "region-name"
    values = [var.region]
  }
}

###############################################################################
# VPC
###############################################################################
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Default subnet for AZ1"
  }
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Default subnet for AZ2"
  }
}

resource "aws_default_subnet" "default_az3" {
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "Default subnet for AZ3"
  }
}
