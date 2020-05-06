FROM ruby:2.7.0-alpine

RUN apk update
RUN apk upgrade

RUN apk add \
      git build-base bash tzdata \
      chromium-chromedriver chromium zlib-dev xorg-server \
      openssh-client

RUN apk add nodejs npm

WORKDIR /usr/src/app

COPY Gemfile* .runner ./
RUN gem update --system && gem install bundler
RUN bundle check || BUNDLE_JOBS=2 bundle install

COPY . .

CMD ./bin/runner --start
