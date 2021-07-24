###############################################################################
# Environment
###############################################################################
aws_account_id = "XXXXXXXXXXXXX"
region         = "XXXXXXXXXXXXX"

###############################################################################
# Security Groups
###############################################################################
source_address = "0.0.0.0/0"

###############################################################################
# EC2
###############################################################################
instance_type = "t2.medium"
key_name      = "XXXXXXXXXXXXX"
ami_centos    = "ami-0b2045146eb00b617"
user_data     = <<EOF
#!/bin/bash

yum update -y
yum install wget -y
wget -O jfrog-rpm-installer.tar.gz "https://releases.jfrog.io/artifactory/jfrog-prox/org/artifactory/pro/rpm/jfrog-platform-trial-prox/[RELEASE]/jfrog-platform-trial-prox-[RELEASE]-rpm.tar.gz"
tar -xvzf jfrog-rpm-installer.tar.gz
cd jfrog-platform-trial-pro*
./install.sh
systemctl start artifactory.service
systemctl start xray.service

#################################################################################
# CHECK STATUS
#################################################################################
#################################################################################
# systemctl status artifactory.service
#################################################################################
systemctl status artifactory.service
#################################################################################
# systemctl status xray.service
#################################################################################
systemctl status xray.service
EOF
