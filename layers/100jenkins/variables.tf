###############################################################################
# Variables - Environment
###############################################################################
variable "aws_account_id" {
  description = "The account ID you are building into."
  type        = string
}

variable "region" {
  description = "The AWS region the state should reside in."
  type        = string
  default     = "ap-southeast-2"
}

###############################################################################
# Variables - Security Groups
###############################################################################
variable "source_address" {
  description = "Whitelisted source address to allow to connect to Jenkins."
  type        = string
  default     = "0.0.0.0/0"
}

###############################################################################
# Variables - EC2
###############################################################################
variable "instance_type" {
  description = "Jenkins EC2 instance type."
  type        = string
  default     = "t2.medium"
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the Jenkins instance."
  type        = string
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}
