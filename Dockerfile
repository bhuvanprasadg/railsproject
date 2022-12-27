FROM ruby:3.0.5-slim-buster

RUN apt-get update -qq \
  && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  vim-tiny \   
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
  /var/lib/apt \
  /var/lib/dpkg \
  /var/lib/cache \
  /var/lib/log

RUN cp /usr/share/zoneinfo/Asia/Singapore /etc/localtime
RUN mkdir /rails_docker
WORKDIR /rails_docker
COPY Gemfile /rails_docker/Gemfile
COPY Gemfile.lock /rails_docker/Gemfile.lock
RUN gem install bundler
RUN bundle update --bundler
RUN bundle install
ADD . /rails_docker
CMD bash -c "rm -f tmp/pids/server.pid && bin/rails s -p 3000 -b '0.0.0.0'"
