[![Build Status](https://semaphoreci.com/api/v1/projects/f5a81c41-e823-496a-9d28-bdebb28110b3/426216/badge.svg)](https://semaphoreci.com/glenbray/forthepet)

forthepet
============

#A bit about the Architecture
At the moment the code is poorly designed and lacks a significant amount of specs. This will have to be addressed after the first release.

# Development Setup
- `rake docker:init`
- docker-compose up

## Temporary

This is temporary until the app is updated to work with the lastest passenger docker image.

Add the following env vars to your profile

`export FORTHEPET_DB_DEV="postgresql://postgres:password@localhost/forthepet_dev?pool=5"`

`export FORTHEPET_DB_TEST="postgresql://postgres:password@localhost/forthepet_test?pool=5"`

- Install ruby 2.3.1
- `bundle install`
- run backend services `docker-compose up db worker mailcatcher`
- run app `bundle exec rails s` or `passenger start` if you have passenger installed


# Backups

## For users with ssh access to production servers.
- If you would like to use data from production run `rake db:backup`

## Users without ssh access

- Get a copy of production backups from someone that has access.
- Place backup file in backups directory
- run `rake db:backup_existing`

# Deployment

Run `cap production deploy`
