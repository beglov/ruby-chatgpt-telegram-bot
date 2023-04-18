FROM ruby

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

CMD ["ruby", "bot.rb"]
