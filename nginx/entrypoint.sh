#!/bin/sh
set -e

for template in /etc/nginx/templates/*.template; do
  filename=$(basename "$template" .template)
  envsubst '${DOMAIN}' < "$template" > "/etc/nginx/conf.d/$filename"
done

exec nginx -g 'daemon off;'
