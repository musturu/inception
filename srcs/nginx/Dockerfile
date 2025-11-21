FROM alpine:3.19

RUN apk add --no-cache nginx openssl curl


RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/CN=$NGINX_HOST"


COPY conf.nginx /etc/nginx/nginx.conf
COPY www/ /usr/share/nginx/html/mysite/
RUN chmod 777 -R /usr/share/nginx/html/mysite

RUN sed -i "s/\$NGINX_HOST/${NGINX_HOST}/g" /etc/nginx/nginx.conf

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]