FROM ruby:2.6.4-alpine

RUN apk add build-base bash tzdata chromium-chromedriver chromium zlib-dev xorg-server

WORKDIR /usr/src/app

COPY Gemfile* .ruby-version ./
RUN gem update --system && gem install bundler
RUN bundle check || bundle install

COPY . .

CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "3008"]
