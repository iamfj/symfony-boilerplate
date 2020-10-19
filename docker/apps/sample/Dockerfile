FROM php:7.4-alpine

COPY --chown=1000:1000 ./apps/sample /var/www/apps/sample
WORKDIR /var/www/apps/sample

RUN export DATABASE_URL= \
 && export APP_ENV=prod \
 && export SYMFONY_ENV=prod \
 && export APP_DEBUG=0 \
 && touch ./.env \
 && apk --update add --no-cache $PHPIZE_DEPS openssl-dev libzip-dev \
 && apk --update add --no-cache --virtual .build-deps composer npm \
 && pecl install apcu \
 && docker-php-ext-install zip pdo_mysql \
 && docker-php-ext-enable apcu pdo_mysql \
 && composer install --no-dev --optimize-autoloader \
 && npm install \
 && npm run build \
 && php bin/console cache:clear \
 && apk del .build-deps \
 && rm -R ./assets ./node_modules ./*.json ./*.lock ./*.js
