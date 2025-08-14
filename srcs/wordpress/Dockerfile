FROM alpine:3.19


# Install PHP-FPM, required PHP extensions, and curl
RUN apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-json \
    php81-session \
    php81-xml \
    php81-curl \
    php81-mbstring \
    gettext \
    curl

RUN getent group www-data || addgroup -g 82 -S www-data
RUN getent passwd www-data || adduser -u 82 -S www-data -G www-data


# Set up working directory
# Add entrypoint script

# Volumes
COPY conf.wordpress /etc/php81/php-fpm.d/www.conf
COPY conf.php /opt/wp-config-template.php

EXPOSE 9000

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
VOLUME /var/www/html
WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]