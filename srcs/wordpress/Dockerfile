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
    curl

# Set up working directory
WORKDIR /var/www/html

# Download and extract WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    cp -a wordpress/. /var/www/html/ && \
    rm -rf wordpress latest.tar.gz

# Set permissions for WordPress files
RUN addgroup -S www || true && adduser -S www -G www || true

# Add entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY conf.wordpress /etc/php81/php-fpm.d/zz-wordpress.conf

# Volumes
VOLUME /var/www/html
VOLUME /var/www/site

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]