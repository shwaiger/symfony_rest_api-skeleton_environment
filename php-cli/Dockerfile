FROM php:7.4.10-cli-alpine

WORKDIR /app

RUN apk add --no-cache --update $PHPIZE_DEPS
RUN apk add --no-cache --update \
        bash \
        nano \
        openssl

RUN docker-php-ext-install pdo_mysql

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
RUN if [ $CONTEXT_ENV != "prod" ]; then pecl install xdebug && docker-php-ext-enable xdebug; fi
## set default php.ini
RUN if [ $CONTEXT_ENV == "prod" ]; then mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini; fi

ARG CONTEXT_FOLDER

COPY $CONTEXT_FOLDER/start.sh /usr/local/bin/

RUN ["chmod", "+x", "/usr/local/bin/start.sh"]

CMD start.sh