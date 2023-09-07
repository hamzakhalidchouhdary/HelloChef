# Set up NodeJs
FROM node:16 AS nodejs

COPY package.json package-lock.json ./

RUN npm install -g @angular/cli

RUN npm install

# Debain Based Ruby 3.0.1
FROM ruby:3.0.1

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# Copy Node.js from the previous stage
COPY --from=nodejs /usr/local /usr/local

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

ENV PORT 4100

EXPOSE $PORT

ENTRYPOINT [ "bundle", "exec" ]

CMD ["rails", "server", "s", "-b", "0.0.0.0", "bash"]