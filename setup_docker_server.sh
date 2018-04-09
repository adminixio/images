!/bin/bash

IMAGE_NAME=$1
PLATFORM=$2
SERVICE_ID=$3
SECRET_KEY=$4

# Installing Docker

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-cache policy docker-ce

sudo apt-get install -y docker-ce

sudo usermod -aG docker ${USER}

# Installing NGINX

sudo apt-get update
sudo apt-get install -y nginx

sudo cat << EOF > default
upstream app {
    server 0.0.0.0:3000;
}

server {
    listen 80;
    server_name default;

    root /var/www/html;

    try_files \$uri/index.html \$uri @app;

    location @app {
        proxy_pass http://app;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header Host \$http_host;
        proxy_redirect off;
    }

    error_page 500 502 503 504 /500.html;
    client_max_body_size 4G;
    keepalive_timeout 10;
}
EOF
sudo mv default /etc/nginx/sites-available/default

sudo systemctl restart nginx.service

sudo docker run -d -p 3000:3000 -e ADMINIX_SECRET_KEY=$SECRET_KEY -e ADMINIX_SERVICE_ID=$SERVICE_ID --restart=always $IMAGE_NAME
