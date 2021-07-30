# Dockerized Xenforo v.2
This a dockerized version of Xenforo v. 2.2.6 patch 2. Due to license protection the Xenforo files can't be uploaded in the repository nor in a Docker image, you would have to manually provide them before starting the containers.

## Installation
1. Place all the Xenforo files in the folder /data/web/var/www/html/.
2. Add in the root folder the SSL certificates (you can use Certbot to create them)
3. Edit the default-site.conf file to match your needs
4. Configure the database credentials in the docker-compose.yml file
5. Start the containers using docker-compose up --build -d
6. Install Xenforo following the official guide