FROM ruby:3.3.5-alpine3.20

WORKDIR /app

RUN apk add make gcc g++

COPY Gemfile /app/Gemfile
COPY app.rb /app/app.rb
COPY config.ru /app/config.ru
COPY helper/request_helper.rb /app/helper/request_helper.rb
COPY helper/custom_controller.rb /app/helper/custom_controller.rb
COPY helper/custom_exporter.rb /app/helper/custom_exporter.rb

EXPOSE 8080
RUN gem install bundler
RUN bundle install
CMD ["bundle", "exec", "rackup", "config.ru", "-o", "0.0.0.0", "-p", "8080"]
