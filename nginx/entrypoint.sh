#!/bin/sh
set -e

# Borra las configs generadas antes para no dejar restos de templates eliminados
for template in /etc/nginx/templates/*.template; do :; done
rm -f /etc/nginx/conf.d/*.conf

for template in /etc/nginx/templates/*.template; do
  [ -e "$template" ] || continue
  filename=$(basename "$template" .template)
  envsubst '${DOMAIN}' < "$template" > "/etc/nginx/conf.d/$filename"
done

nginx -t
exec nginx -g 'daemon off;'
