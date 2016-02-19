FROM php:5.6-fpm

# Install require extension for Laravel
RUN apt-get update -y && apt-get install -y libmcrypt-dev zlib1g-dev && apt-get clean
RUN docker-php-ext-install mbstring mcrypt pdo_mysql

# RUN docker-php-ext-install json
# RUN docker-php-ext-install tokenizer

# Install Composer
RUN apt-get update -y && apt-get install -y curl git zlib1g-dev && apt-get clean
RUN docker-php-ext-install zip
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN apt-get update -y && apt-get install libmemcached-dev libssl-dev -y && apt-get clean
RUN pecl install mongo redis memcached && \
    echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini && \
    echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini && \
    echo "extension=memcached.so" > /usr/local/etc/php/conf.d/memcached.ini

CMD ["php-fpm"]
