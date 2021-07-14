FROM php:8.0-fpm-alpine
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN apk update && apk add --no-cache nginx wget &&\
    chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd pdo_mysql pgsql pdo_pgsql zip pdo_odbc intl exif &&\
    wget -q https://github.com/fisharebest/webtrees/archive/main.zip &&\
    unzip -q main.zip -d /var/www/ &&\
    mv /var/www/webtrees*/* /var/www/html/ &&\
    curl -s https://api.github.com/repos/fisharebest/webtrees/releases/latest \
    | grep browser_download_url \
    | cut -d '"' -f 4 \
    | wget -qi - &&\
    unzip -q webtrees*.zip &&\
    cp -r webtrees/resources/lang/* /var/www/html/resources/lang &&\
    rm -rf webtrees* main.zip /var/www/webtrees* &&\
    cd /var/www/html && curl -sS https://getcomposer.org/installer | php && php composer.phar install --no-dev &&\
    chown -R nginx:nginx /var/www/ &&\
    apk del --purge wget
RUN rm /usr/local/etc/php-fpm.d/docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY default.conf /etc/nginx/conf.d/
COPY docker-entrypoint /usr/local/bin/
COPY www.conf /usr/local/etc/php-fpm.d/
EXPOSE 80/tcp
ENTRYPOINT ["docker-entrypoint"]
