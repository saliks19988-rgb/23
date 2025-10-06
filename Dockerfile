# PHP image
FROM php:8.3-apache

# enable required packages and gd lib
RUN apt-get update && apt-get install -y \
    libwebp-dev libxpm-dev zlib1g-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    unzip \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j"$(nproc)" gd zip mysqli \
 && docker-php-ext-enable mysqli zip opcache

# enable recommended PHP production settings via opcache
RUN { \
  echo 'opcache.enable=1'; \
  echo 'opcache.enable_cli=1'; \
  echo 'opcache.validate_timestamps=0'; \
  echo 'opcache.jit_buffer_size=128M'; \
  echo 'opcache.jit=tracing'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# set working directory
WORKDIR /var/www/html

# copy project files
COPY . /var/www/html

# set server name >> localhost
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# enable apache rewrite mod
RUN a2enmod rewrite

# restart server
# no need to restart; container CMD will start apache

# listen to port 80
EXPOSE 80

# run apache foreground
CMD ["apache2-foreground"]