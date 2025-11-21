FROM alpine:3.19


# Install Grafana and its dependencies
RUN apk update && apk add --no-cache grafana
USER root
# Copy provisioning config
COPY provisioning/datasources/mariadb.yml /etc/grafana/provisioning/datasources/mariadb.yml
RUN chmod -R 777 /etc/grafana/provisioning
COPY grafana.ini /etc/grafana/grafana.ini
RUN chmod -R 777 /etc/grafana/grafana.ini

EXPOSE 3000

USER grafana
WORKDIR /var/lib/grafana

ENTRYPOINT ["/usr/sbin/grafana-server", "--homepath=/usr/share/grafana", "--config=/etc/grafana/grafana.ini"]
