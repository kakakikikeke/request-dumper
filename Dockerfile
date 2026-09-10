FROM ruby:4.0.5-alpine3.23

WORKDIR /app

RUN apk add make gcc g++ yaml-dev

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY app.rb /app/app.rb
COPY config.ru /app/config.ru
COPY puma.rb /app/puma.rb
COPY controller /app/controller
COPY repository /app/repository
COPY service /app/service
COPY helper/custom_controller.rb /app/helper/custom_controller.rb
COPY helper/custom_exporter.rb /app/helper/custom_exporter.rb

EXPOSE 8080
RUN gem install bundler -v 2.5.16
RUN bundle config set deployment true && bundle install
RUN addgroup -S request-dumper && adduser -S request-dumper -G request-dumper \
	&& chown -R request-dumper:request-dumper /app
USER request-dumper
CMD ["bundle", "exec", "puma", "-C", "puma.rb", "-b", "tcp://0.0.0.0:8080", "config.ru"]
