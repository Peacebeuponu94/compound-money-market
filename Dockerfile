FROM mhart/alpine-node:10.4.1@sha256:d81ab942799faf39807c7ad45023503dadc4ba069320848879ad3d70e6beef30

RUN apk update && apk add --no-cache --virtual build-dependencies git python g++ make
RUN yarn global add truffle@4.1.11
RUN yarn global add ganache-cli@6.1.3

RUN mkdir -p /deploy/money-market
WORKDIR /deploy/money-market

# First add deps
ADD ./package.json /deploy/money-market/
ADD ./yarn.lock /deploy/money-market/
RUN yarn

# Then rest of code and build
ADD . /deploy/money-market

RUN truffle compile

RUN apk del build-dependencies
RUN yarn cache clean

CMD while :; do sleep 2073600; done
