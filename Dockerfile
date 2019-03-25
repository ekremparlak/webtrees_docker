FROM alpine
RUN apk add tar xz php php7-fpm php7-pdo_mysql php-json php-mbstring php-iconv php-session php-xml php-curl php-gd php-simplexml nginx wget php7-pdo_sqlite php7-sqlite3
RUN wget -P /var/www/ https://github.com/fisharebest/webtrees/archive/master.zip
RUN unzip /var/www/master.zip -d /var/www/
RUN rm /var/www/master.zip
RUN chown -R nginx:nginx /var/www/
RUN mkdir /run/nginx
COPY default.conf /etc/nginx/conf.d/
COPY www.conf /etc/php7/php-fpm.d/
COPY docker-entrypoint /usr/local/bin/
EXPOSE 80/tcp
ENTRYPOINT ["docker-entrypoint"]
