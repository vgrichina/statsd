FROM node:12.18.3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install python
# RUN apk add --no-cache --update g++ gcc libgcc libstdc++ linux-headers make python

# Setup node envs
ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

# Install dependencies
COPY package.json /usr/src/app/
RUN npm install && npm cache clean --force

# Copy required src (see .dockerignore)
COPY . /usr/src/app

# Expose required ports
EXPOSE 8125/udp
EXPOSE 8126

# Start statsd
ENTRYPOINT [ "node", "stats.js", "exampleConfig.js" ]
