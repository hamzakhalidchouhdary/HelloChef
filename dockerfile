# Debain Based Ruby 3.0.1
FROM ruby:3.0.1


# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

ENV PORT 3000

EXPOSE $PORT

ENTRYPOINT [ "bundle", "exec" ]

CMD ["rails", "server", "s", "-b", "0.0.0.0", "bash"]