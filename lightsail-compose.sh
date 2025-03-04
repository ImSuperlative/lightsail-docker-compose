#!/bin/bash

# fix interactive install
export DEBIAN_FRONTEND=noninteractive

# install latest version of docker the lazy way
curl -sSL https://get.docker.com | sh

# make it so you don't need to sudo to run docker commands
usermod -aG docker ubuntu

# install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

mkdir -p /srv
chown ubuntu -R /srv

# Create Docker Compose service file
cat <<EOF | sudo tee /etc/systemd/system/docker-compose-app.service
[Unit]
Description=Docker Compose Application Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
# match the below to wherever you copied your docker-compose.yml
WorkingDirectory=/srv/docker
EnvironmentFile=/etc/environment
EnvironmentFile=/srv/docker/.env
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd to recognize the new service
sudo systemctl daemon-reload

# Enable the service to start on boot
sudo systemctl enable docker-compose-app