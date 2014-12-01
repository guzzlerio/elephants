FROM node
MAINTAINER "guzzler"

RUN mkdir -p /app
WORKDIR /app

COPY . /app

CMD ["node", "app.js"]

EXPOSE 3000
