FROM alpine:3.12.4

RUN apk add --update nodejs npm
RUN apk add --update npm yarn git
RUN apk add --no-cache g++ git make

WORKDIR /analysis
COPY analysis/package.json analysis/yarn.lock ./
RUN yarn install
COPY analysis/ ./
RUN yarn dist

WORKDIR /analysis-node
COPY analysis-node/package.json analysis-node/yarn.lock ./
RUN yarn install
COPY analysis-node/ ./
RUN bin/build

CMD ["node", "build/index.js"]
