FROM alpine:3.19


# Install Grafana and its dependencies
RUN apk update && apk add --no-cache grafana

# Copy provisioning config
COPY provisioning/datasources/mariadb.yml /etc/grafana/provisioning/datasources/mariadb.yml

EXPOSE 3000

USER grafana
WORKDIR /var/lib/grafana

ENTRYPOINT ["/usr/sbin/grafana-server", "--homepath=/usr/share/grafana", "--config=/etc/grafana/grafana.ini"]
