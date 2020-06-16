FROM ruby:2.5.1

RUN apt-get update && \
    apt-get install -y build-essential libpq-dev postgresql-client

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -  && \
    apt-get install -y nodejs

RUN mkdir /memoryfootprint

ENV APP_ROOT /memoryfootprint

WORKDIR ${APP_ROOT}

ADD Gemfile ${APP_ROOT}/Gemfile
ADD Gemfile.lock ${APP_ROOT}/Gemfile.lock
ENV BUNDLER_VERSION 2.0.2
RUN gem install bundler -v '2.0.2'  && bundle install

ADD . ${APP_ROOT}
EXPOSE 3000