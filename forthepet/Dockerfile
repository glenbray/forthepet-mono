FROM phusion/passenger-ruby23:0.9.19

RUN curl -sL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list'

# Nodejs
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

# Install system dependencies
RUN apt-get update
RUN apt-get install -y build-essential libpq-dev sqlite3 libsqlite3-dev postgresql-client-9.3 nodejs

RUN rm -f /etc/localtime
RUN ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime

# create app directory
RUN mkdir /home/app/forthepet/
WORKDIR /home/app/forthepet/

# Copy gemfile to image
ADD Gemfile /home/app/forthepet/Gemfile
ADD Gemfile.lock /home/app/forthepet/Gemfile.lock

# Install project dependencies
ENV BUNDLE_JOBS=4
ENV BUNDLE_PATH=/bundle

RUN gem install bundler -v '1.12.5'
RUN bundle install --without development test
# RUN /usr/local/rvm/bin/rvm wrapper ruby-2.3.1 --no-prefix --all
RUN cd /usr/local/rvm/bin/ && ./rvm get stable && ./rvm reload && ./rvm repair all

# Add forthepet project to docker image
ADD . /home/app/forthepet/
RUN chown -R app:app /home/app/forthepet/

EXPOSE 80

CMD ["/sbin/my_init"]
