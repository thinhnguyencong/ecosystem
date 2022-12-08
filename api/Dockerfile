FROM node:16-alpine as node
WORKDIR /app
COPY . .
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

# RUN apk add g++ make py3-pip
# RUN apk add --no-cache rust cargo
# RUN apk add pkgconfig openssl openssl-dev musl-dev

# # RUN cd rust-2 && cargo build --release
# RUN npm install -g node-gyp
RUN npm install
# RUN npm run init
EXPOSE 5555

CMD ["npm", "run", "dev"]