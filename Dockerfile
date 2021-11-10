# étape de build
FROM node:16.9.1-alpine as build-stage
WORKDIR /app
COPY ./src/package*.json ./
RUN npm install
COPY ./src/ ./
RUN npm run build

# étape de production
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT [ "nginx -g 'daemon off;'" ]