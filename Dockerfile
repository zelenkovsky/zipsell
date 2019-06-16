FROM ruby:2.4.1-slim-stretch

MAINTAINER Dmitry Zelenkovsky <Dmitry.Zelenkovsky@lge.com>

ENV DEPLOYMENT_PATH /var/www

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y -qq \
      gcc            \
      make           \
      libpq-dev      \
      libsqlite3-dev \
      ruby2.3-dev    \
      nodejs         \
      git

RUN mkdir -p ${DEPLOYMENT_PATH} && \
    cd ${DEPLOYMENT_PATH} && git clone https://github.com/yongfook/zipsell.git && \
    cd ${DEPLOYMENT_PATH}/zipsell && ./bin/setup

COPY application.yml ${DEPLOYMENT_PATH}/zipsell/config

WORKDIR ${DEPLOYMENT_PATH}/zipsell

EXPOSE 3000/tcp

CMD [ "rails", "s" ]
