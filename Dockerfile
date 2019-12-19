FROM alpine
RUN apk add tar xz php php7-fpm php7-pdo_mysql php-json php-mbstring php-iconv php-session php-xml php-curl php-gd php-simplexml php-fileinfo nginx wget php7-pdo_sqlite php7-pdo_odbc php7-pdo_pgsql php7-sqlite3 php-zip &&\
    wget -P /var/www/ https://github.com/fisharebest/webtrees/archive/master.zip &&\
    unzip /var/www/master.zip -d /var/www/ &&\
    wget https://github.com/fisharebest/webtrees/releases/download/2.0.0/webtrees-2.0.0.zip &&\
    unzip webtrees-2.0.0.zip &&\
    cp -r webtrees/resources/lang/* /var/www/webtrees-master/resources/lang &&\
    rm -r webtrees* &&\
    rm /var/www/master.zip &&\
    chown -R nginx:nginx /var/www/ &&\
    apk del wget
RUN mkdir /run/nginx
COPY default.conf /etc/nginx/conf.d/
COPY www.conf /etc/php7/php-fpm.d/
COPY config.ini.php webtrees.sqlite /var/www/webtrees-master/data/
RUN chown nginx:nginx /var/www/webtrees-master/data/config.ini.php /var/www/webtrees-master/data/webtrees.sqlite
COPY docker-entrypoint /usr/local/bin/
EXPOSE 80/tcp
ENTRYPOINT ["docker-entrypoint"]