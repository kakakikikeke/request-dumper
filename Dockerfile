FROM ruby

RUN gem install bundler

COPY . /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY app.rb /app/app.rb
COPY config.ru /app/config.ru
COPY helper/request-helper.rb /app/helper/request-helper.rb

EXPOSE 8080
RUN bundle install
CMD ["bundle", "exec", "rackup", "config.ru", "-o", "0.0.0.0", "-p", "8080"]