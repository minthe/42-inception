FROM alpine:3.17.4

ARG MYSQL_USER MYSQL_PASSWORD MYSQL_DATABASE WP_TITLE WP_TITLE WP_ADMIN_PASSWORD WP_ADMIN_EMAIL WP_GUEST WP_GUEST_PASSWORD WP_GUEST_EMAIL

RUN apk update; apk upgrade; apk add wget php php81-fpm php81-mysqli \
	php81-phar mariadb-client php81-dom php81-json php81-curl php81-openssl \
	php81-xml php81-zip php81-mbstring php81-fileinfo

RUN wget https://wordpress.org/wordpress-6.2.2.tar.gz -P /var/www ; cd /var/www && \
	tar -xzf wordpress-6.2.2.tar.gz && rm wordpress-6.2.2.tar.gz

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar ; \
	chmod +x wp-cli.phar ; mv /wp-cli.phar /usr/bin/wp ; \
	sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php81/php-fpm.d/www.conf

COPY conf/conf.sh auto_config.sh

EXPOSE 9000

WORKDIR /var/www/wordpress

ENTRYPOINT [ "sh", "/auto_config.sh" ]

CMD [ "/usr/sbin/php-fpm81", "-F" ]