#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Update system packages
dnf update -y

# Install Docker
dnf install -y docker

# Start and enable Docker service
systemctl enable --now docker

# Allow ec2-user to run Docker without sudo
usermod -aG docker ec2-user

# Install Docker Compose (latest stable release)
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create the /srv directory and assign ownership to ec2-user
mkdir -p /srv
chown ec2-user -R /srv

# Print Docker & Docker Compose versions
docker --version
docker-compose --version

echo "Docker and Docker Compose installation is complete!"