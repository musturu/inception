FROM alpine:3.19

RUN apk update && apk add vsftpd


# Copy vsftpd config
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose FTP ports
EXPOSE 21 20

# Point to Wordpress volume
VOLUME ["/var/www/html"]

ENTRYPOINT ["/entrypoint.sh"]
