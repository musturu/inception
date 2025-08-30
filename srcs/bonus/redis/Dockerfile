FROM alpine:3.19

RUN apk add --no-cache redis

EXPOSE 6379

USER redis
WORKDIR /data

ENTRYPOINT ["redis-server", "--protected-mode", "no", "--dir", "/data"]