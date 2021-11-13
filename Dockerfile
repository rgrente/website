# étape de build
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY ./package*.json ./
RUN npm -v
RUN npm install
COPY . ./
RUN npm run build

# étape de production
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT [ "nginx -g 'daemon off;'" ]