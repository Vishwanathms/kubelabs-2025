FROM nginx:latest
COPY index.html.template /usr/share/nginx/html/index.html.template
COPY entrypoint.sh /docker-entrypoint.d/entrypoint.sh
RUN chmod +x /docker-entrypoint.d/entrypoint.sh
