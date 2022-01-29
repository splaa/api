FROM alpine:3.13

# for laravel lumen run smoothly
RUN apk --no-cache add \
php7 \
php7-fpm \
php7-pdo \
php7-mbstring \
php7-openssl

# for our code run smoothly
RUN apk --no-cache add \
php7-json \
php7-dom \
curl \
php7-curl

# for swagger run smoothly
RUN apk --no-cache add \
php7-tokenizer

# for composer & our project depency run smoothly
RUN apk --no-cache add \
php7-phar \
php7-xml \
php7-xmlwriter

# if need composer to update plugin / vendor used
RUN php7 -r "copy('http://getcomposer.org/installer', 'composer-setup.php');" && \
php7 composer-setup.php --install-dir=/usr/bin --filename=composer && \
php7 -r "unlink('composer-setup.php');"

# RUN ln -sf /usr/bin/php7 /usr/bin/php && \
# ln -s /etc/php7/php.ini /etc/php7/conf.d/php.ini

# RUN set -x \
# addgroup -g 82 -S www-data \
# adduser -u 82 -D -S -G www-data www-data

# copy all of the file in folder to /src
COPY . /src
WORKDIR /src

RUN composer update

# ADD .env.example /src/.env
# RUN chmod -R 777 storage

# run the php server service
# move this command to -> docker-compose.yml
# CMD php -S 0.0.0.0:8080 public/index.php
