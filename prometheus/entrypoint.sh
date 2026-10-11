#!/bin/sh
set -e

# Generate the final Prometheus config from the template, substituting
# environment variables for sensitive values (Bearer token, internal hosts).
envsubst < /etc/prometheus/prom.yml.template > /etc/prometheus/prom.yml

exec /bin/prometheus --config.file=/etc/prometheus/prom.yml --storage.tsdb.path=/prometheus "$@"
