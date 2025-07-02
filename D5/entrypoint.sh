#!/bin/sh
envsubst < /usr/share/nginx/html/index.html.template > /usr/share/nginx/html/index.html
exec nginx -g 'daemon off;'
