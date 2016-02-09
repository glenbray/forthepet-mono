FROM ruby:2.2.0

# Postgres client
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'

# Nodejs
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

RUN apt-get install -y build-essential libpq-dev sqlite3 libsqlite3-dev postgresql-client-9.3 nodejs

RUN mkdir /forthepet
WORKDIR /forthepet
ADD Gemfile /forthepet/Gemfile
ADD Gemfile.lock /forthepet/Gemfile.lock
RUN bundle install

RUN gem install mailcatcher

ADD . /forthepet
