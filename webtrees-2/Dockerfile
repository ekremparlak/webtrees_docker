FROM php:7.4-fpm-alpine
ARG VERSION=2.0.3
ENV PHP_MAX_EXE 60
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN apk update && apk add --no-cache nginx &&\
    chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd pdo_mysql pgsql pdo_pgsql zip pdo_odbc intl exif &&\
    wget -q https://github.com/fisharebest/webtrees/releases/download/$VERSION/webtrees-$VERSION.zip &&\
    unzip webtrees*.zip -d /var/www/ &&\
    mv /var/www/webtrees*/* /var/www/html/ &&\
    rm -rf webtrees* /var/www/webtrees* &&\
    chown -R nginx:nginx /var/www/
RUN mkdir /run/nginx
RUN rm /usr/local/etc/php-fpm.d/docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY default.conf /etc/nginx/http.d/
COPY docker-entrypoint /usr/local/bin/
COPY www.conf /usr/local/etc/php-fpm.d/
EXPOSE 80/tcp
ENTRYPOINT ["docker-entrypoint"]
