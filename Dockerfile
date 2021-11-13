# étape de production
FROM nginx:stable-alpine as production-stage
RUN ls
COPY public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT [ "nginx -g 'daemon off;'" ]