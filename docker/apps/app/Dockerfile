FROM php:7.4-alpine

COPY --chown=1000:1000 ./apps/app /var/www/apps/app
WORKDIR /var/www/apps/app

RUN export DATABASE_URL= \
 && export APP_ENV=prod \
 && export SYMFONY_ENV=prod \
 && export APP_DEBUG=0 \
 && touch ./.env \
 && apk --update add --no-cache $PHPIZE_DEPS openssl-dev libzip-dev \
 && apk --update add --no-cache --virtual .build-deps composer yarn \
 && docker-php-ext-install pdo_mysql \
 && pecl install apcu \
 && docker-php-ext-install zip \
 && docker-php-ext-enable apcu \
 && composer install --no-dev --optimize-autoloader \
 && yarn install \
 && yarn encore production \
 && php bin/console cache:clear \
 && apk del .build-deps \
 && rm -R ./assets ./node_modules ./*.json ./*.lock ./*.js
