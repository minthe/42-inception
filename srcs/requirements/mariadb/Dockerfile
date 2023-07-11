FROM alpine:3.17.4

ARG MYSQL_PASSWORD MYSQL_USER MYSQL_ROOT_PASSWORD MYSQL_DATABASE

RUN apk update && apk add mariadb mariadb-client

COPY conf/config_mariadb.sh /

RUN mysql_install_db --datadir=/var/lib/mysql --user=mysql;

RUN chown root /config_mariadb.sh
RUN chmod +x /config_mariadb.sh
RUN sh /config_mariadb.sh

HEALTHCHECK --start-period=1m \
  CMD mariadb -u $MYSQL_USER -p$MYSQL_PASSWORD -e 'SELECT @@datadir;' || exit 1

EXPOSE 3306

ENTRYPOINT ["/usr/bin/mysqld", "--user=mysql", "--console"]