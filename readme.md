All credits to https://github.com/hashdog/lightsail-docker-compose


Enter the following code into the dialog box:

```
curl -o lightsail-compose.sh https://raw.githubusercontent.com/ImSuperlative/lightsail-docker-compose/main/lightsail-compose.sh

chmod +x ./lightsail-compose.sh

./lightsail-compose.sh
```

LOGIN add .env and docker-compose.glitchTip.yml and run
curl -o docker-compose.glitchTip.yml https://raw.githubusercontent.com/ImSuperlative/lightsail-docker-compose/main/docker-compose.glitchtip.yml

```
curl -o install_docker_compose_service.sh https://raw.githubusercontent.com/ImSuperlative/lightsail-docker-compose/main/install_docker_compose_service.sh

chmod +x ./install_docker_compose_service.sh

./install_docker_compose_service.sh
```


sudo systemctl restart docker-compose-app


sudo dnf install nginx -y
curl -o glitchtip.conf https://raw.githubusercontent.com/ImSuperlative/lightsail-docker-compose/main/glitchtip.conf
sudo cp glitchtip.conf /etc/nginx/sites-enabled/glitchtip.conf