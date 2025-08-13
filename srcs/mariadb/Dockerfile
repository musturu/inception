FROM alpine:3.19

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
VOLUME /var/lib/mysql
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

COPY entrypoint.sh /entrypoint.sh
COPY conf.mariadb /etc/my.cnf
RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]