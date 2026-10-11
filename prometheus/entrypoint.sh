#!/bin/sh
set -e

# Generate the final Prometheus config from the template, substituting
# environment variables for sensitive values (Bearer token, internal hosts).
sed \
  -e "s|\\\${TERRALINK_METRICS_TOKEN}|${TERRALINK_METRICS_TOKEN}|g" \
  -e "s|\\\${TERRALINK_DOMAIN}|${TERRALINK_DOMAIN}|g" \
  -e "s|\\\${POSTGRES_EXPORTER_HOST}|${POSTGRES_EXPORTER_HOST}|g" \
  -e "s|\\\${REDIS_EXPORTER_HOST}|${REDIS_EXPORTER_HOST}|g" \
  /etc/prometheus/prom.yml.template > /etc/prometheus/prom.yml

exec /bin/prometheus --config.file=/etc/prometheus/prom.yml --storage.tsdb.path=/prometheus "$@"
