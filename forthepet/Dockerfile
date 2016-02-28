FROM phusion/passenger-ruby22

# Postgres client
RUN apt-get update
RUN apt-get install wget
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'

# Nodejs
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

# # Install system dependencies
RUN apt-get update
RUN apt-get install -y build-essential libpq-dev sqlite3 libsqlite3-dev postgresql-client-9.3 nodejs

# # Set Sydney time
RUN rm -f /etc/localtime
RUN ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime

# create app directory
RUN mkdir /home/app/forthepet/
WORKDIR /home/app/forthepet/

# Copy gemfile to image
ADD Gemfile /home/app/forthepet/Gemfile
ADD Gemfile.lock /home/app/forthepet/Gemfile.lock

# # Install project dependencies
ENV BUNDLE_JOBS 4

RUN gem update bundler
RUN bundle install --without development test

# Add forthepet project to docker image
ADD . /home/app/forthepet/
RUN chown -R app:app /home/app/forthepet/

EXPOSE 80

CMD ["/sbin/my_init"]
