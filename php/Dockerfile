FROM php:7.4.10-fpm-alpine

WORKDIR /app

RUN apk add --no-cache --update $PHPIZE_DEPS
RUN apk add --no-cache --update \
        bash \
        nano \
        openssl \
        postgresql-dev

RUN docker-php-ext-install pdo_pgsql

RUN apk add --no-cache --update \
        libpng-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        jpeg-dev && \
    docker-php-ext-configure gd \
            --with-jpeg=/usr/include/ \
            --with-freetype=/usr/include/ && \
    docker-php-ext-install gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

## install apcu
RUN pecl install apcu && \
    docker-php-ext-enable apcu

RUN docker-php-ext-install opcache && \
    docker-php-ext-enable opcache

RUN echo 'alias sf="php bin/console"' >> ~/.bashrc
RUN mkdir -p var/cache var/log && chown -R www-data var/cache var/log

ARG CONTEXT_ENV

## install xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

## set default php.ini
RUN if [ $CONTEXT_ENV == "prod" ]; then mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini; fi

#generate rsa keys for oAuth
RUN mkdir /var/oauth && cd /var/oauth && \
    openssl genrsa -out private.key 2048 && openssl rsa -in private.key -pubout -out public.key && \
    chmod 404 private.key

EXPOSE 9000

CMD ["php-fpm"]
