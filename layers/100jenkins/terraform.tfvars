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
user_data     = <<EOF
#!/bin/bash

# this script is only tested on ubuntu xenial

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

# run jenkins
mkdir -p /var/jenkins_home
chown -R 1000:1000 /var/jenkins_home/
git clone https://github.com/antonio-rufo/jenkins-docker.git
cd jenkins-docker
docker build -t jenkins-docker .
docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --name jenkins -d jenkins-docker

# show endpoint
echo 'Jenkins installed'
echo 'You should now be able to access jenkins at: http://'$(curl -s ifconfig.co)':8080'
EOF
