FROM php:8.0-apache
ENV WEB_DIR="/var/www/html"
WORKDIR ${WEB_DIR}
RUN apt update -y
RUN apt install -y git curl tar unzip openssl ssl-cert libzip-dev libxml2-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev cron redis libwebp-dev libgmp3-dev
RUN docker-php-ext-install pdo pdo_mysql tokenizer bcmath xml zip mysqli gmp
RUN docker-php-ext-enable mysqli
RUN docker-php-ext-configure \
        gd --enable-gd --with-freetype --with-jpeg --with-webp
RUN NUMPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NUMPROC} gd
RUN chmod 777 -R /var/www/html
RUN chown www-data:www-data -R /var/www/html
RUN a2enmod rewrite
RUN rm /etc/apache2/sites-available/* && rm /etc/apache2/sites-enabled/*
COPY default-site.conf /etc/apache2/sites-available
COPY fullchain.pem /etc/apache2
COPY privkey.pem /etc/apache2
RUN a2enmod ssl
RUN a2enmod rewrite
RUN a2ensite *
RUN service apache2 restart
EXPOSE 80 443
