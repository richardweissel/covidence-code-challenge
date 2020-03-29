FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y build-essential
RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
RUN gem install bundler
RUN bundle install

ENV PORT 3000
#ENV GEM_HOME /app/.gem
#ENV PATH $PATH:/app/.gem/bin

COPY . /app

