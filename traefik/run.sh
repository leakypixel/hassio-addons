#!/usr/bin/env bashio

bashio::log.info "Ensuring SSL directory..."
mkdir -p /ssl/traefik/

bashio::log.info "Generating static config..."
j2 /etc/traefik/traefik.yaml.j2 /data/options.json -o /etc/traefik/traefik.yaml
bashio::log.info "Static config generated"

bashio::log.info "Extracting environment variables..."
ENV_VARS=$(j2 /etc/traefik/env.j2 /data/options.json)

if [ -z "$ENV_VARS" ]; then
    bashio::log.info "No additional environment variables found"
else
    bashio::log.info "Extracted variables ${ENV_VARS}"
fi

bashio::log.info "Starting Nginx for dashboard..."
nginx -g 'pid /tmp/nginx.pid;'

bashio::log.info "Starting Traefik..."
if [ -z "$ENV_VARS" ]; then
    bashio::log.info "Running Traefik without env_vars"
    /usr/local/bin/traefik
else
    env $ENV_VARS /usr/local/bin/traefik
fi
