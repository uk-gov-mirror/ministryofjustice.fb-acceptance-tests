FROM ruby:2.6.4-alpine

RUN apk add build-base bash tzdata

WORKDIR /usr/src/app

COPY Gemfile* .ruby-version ./
RUN gem update --system && gem install bundler
RUN bundle check || BUNDLE_JOBS=2 bundle install

COPY . .

CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "3000"]
