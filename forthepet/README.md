[![Build Status](https://semaphoreci.com/api/v1/projects/f5a81c41-e823-496a-9d28-bdebb28110b3/426216/badge.svg)](https://semaphoreci.com/glenbray/forthepet)

forthepet
============

#A bit about the Architecture
At the moment the code is poorly designed and lacks a significant amount of specs. This will have to be addressed after the first release.

# Deployment

Run `cap production deploy`

# Set up with Docker
- `rake docker:init`
- docker-compose up

# Backups

## For users with ssh access to production servers.
- If you would like to use data from production run `rake db:backup`

## Users without ssh access

- Get a copy of production backups from someone that has access.
- Place backup file in backups directory
- run `rake db:backup_existing`
