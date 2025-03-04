#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Define service file path
SERVICE_FILE="/etc/systemd/system/docker-compose-app.service"
WORKING_DIR="/srv"
DOCKER_COMPOSE_FILE="docker-compose.glitchTip.yml"

# Create the working directory
mkdir -p $WORKING_DIR
chown ec2-user:ec2-user -R $WORKING_DIR

# Create the systemd service file
cat <<EOF > $SERVICE_FILE
[Unit]
Description=Docker Compose Application Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=$WORKING_DIR
EnvironmentFile=/etc/environment
EnvironmentFile=$WORKING_DIR/.env
ExecStart=/usr/local/bin/docker-compose -f $DOCKER_COMPOSE_FILE up -d
ExecStop=/usr/local/bin/docker-compose -f $DOCKER_COMPOSE_FILE down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd to recognize the new service
systemctl daemon-reload

# Enable and start the service
systemctl enable --now docker-compose-app.service

echo "Docker Compose service has been installed and started successfully!"