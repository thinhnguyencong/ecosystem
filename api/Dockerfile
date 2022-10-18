FROM node:16-alpine

WORKDIR /app

COPY . .

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

RUN npm install

EXPOSE 5555

CMD ["npm", "start"]