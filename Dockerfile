FROM ruby:2.5.1

RUN apt-get update && \
    apt-get install -y build-essential libpq-dev postgresql-client

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -  && \
    apt-get install -y nodejs

RUN apt-get update && apt-get install -y unzip && \
    CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    wget -N http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -P ~/ && \
    unzip ~/chromedriver_linux64.zip -d ~/ && \
    rm ~/chromedriver_linux64.zip && \
    chown root:root ~/chromedriver && \
    chmod 755 ~/chromedriver && \
    mv ~/chromedriver /usr/bin/chromedriver && \
    sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && apt-get install -y google-chrome-stable && \
    apt-get install graphviz

RUN mkdir /memoryfootprint

ENV APP_ROOT /memoryfootprint

WORKDIR ${APP_ROOT}

ADD Gemfile ${APP_ROOT}/Gemfile
ADD Gemfile.lock ${APP_ROOT}/Gemfile.lock
ENV BUNDLER_VERSION 2.1.4
RUN gem install bundler -v '2.1.4'  && bundle install

ADD . ${APP_ROOT}
EXPOSE 3000