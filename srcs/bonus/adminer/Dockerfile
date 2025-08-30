FROM alpine:3.19

# Install PHP and required extensions
RUN apk add --no-cache php php-pdo php-pdo_mysql php-mysqli php-session php-json php-xml php-mbstring php-gd php-openssl php-curl

# Download Adminer
ENV ADMINER_VERSION 5.3.0
ADD https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php /var/www/html/index.php

# Set permissions
RUN mkdir -p /var/www/html && \
    chown -R nobody:nobody /var/www/html && \
    chmod 755 /var/www/html/index.php

# Use nobody user for security
USER nobody

# Expose port
EXPOSE 8080

# Start PHP built-in server
ENTRYPOINT ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]