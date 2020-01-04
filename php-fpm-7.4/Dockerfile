FROM php:7.4-fpm-alpine
RUN apk update && apk add --no-cache nginx wget oniguruma libzip-dev libpng-dev unixodbc-dev postgresql-libs postgresql-dev &&\
    docker-php-ext-install gd pdo_mysql pgsql pdo_pgsql zip &&\
    docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr &&\
    docker-php-ext-install pdo_odbc &&\
    wget -q https://github.com/fisharebest/webtrees/archive/master.zip &&\
    unzip master.zip -d /var/www/ &&\
    mv /var/www/webtrees*/* /var/www/html/ &&\
    curl -s https://api.github.com/repos/fisharebest/webtrees/releases/latest \
    | grep browser_download_url \
    | cut -d '"' -f 4 \
    | wget -qi - &&\
    unzip webtrees*.zip &&\
    cp -r webtrees/resources/lang/* /var/www/html/resources/lang &&\
    rm -rf webtrees* master.zip /var/www/webtrees* &&\
    chown -R nginx:nginx /var/www/ &&\
    apk del wget
RUN mkdir /run/nginx
RUN rm /usr/local/etc/php-fpm.d/docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY default.conf /etc/nginx/conf.d/
COPY docker-entrypoint /usr/local/bin/
COPY www.conf /usr/local/etc/php-fpm.d/
EXPOSE 80/tcp
ENTRYPOINT ["docker-entrypoint"]