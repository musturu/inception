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
WORKDIR /var/www/html

# Download and extract WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    cp -a wordpress/. /var/www/html/ && \
    rm -rf wordpress latest.tar.gz


# Add entrypoint script

# Volumes
VOLUME /var/www/html
COPY conf.wordpress /etc/php81/php-fpm.d/zz-wordpress.conf
COPY conf.php /opt/wp-config-template.php

EXPOSE 9000

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]