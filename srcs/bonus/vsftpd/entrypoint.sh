#!/bin/sh
set -e

FTP_PASS=$(cat /run/secrets/ftp_password)
adduser -D -h /var/www/html ftpuser && \
echo "ftpuser:$FTP_PASS" | chpasswd

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
