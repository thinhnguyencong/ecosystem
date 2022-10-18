# build stage
FROM node:16-alpine as build-stage
WORKDIR /app
COPY . .
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
RUN npm install
RUN npm run build

# production stage
FROM nginx:1.17-alpine as production-stage
COPY --from=build-stage /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]