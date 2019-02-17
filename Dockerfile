FROM mhart/alpine-node:11.10.0
WORKDIR /app
COPY package.json ./

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

RUN apk --no-cache add --virtual native-deps \
  g++ gcc libgcc libstdc++ linux-headers make python && \
  npm install --quiet node-gyp -g &&\
  npm install --quiet && \
  apk del native-deps

RUN npm install

COPY ./docker-entrypoint.sh /

COPY . .

EXPOSE 9898

ENTRYPOINT ["sh", "/docker-entrypoint.sh"] 
