namespace :docker do
  desc "setup project for development"
  task :init do
    system("docker build -t forthepet .")
    system("docker-compose build")
    system("docker-compose run web bundle install")
    # system("docker-compose run web npm install")
    # system("docker-compose run web bundle exec rake assets:webpack")
    system("docker-compose run web bundle exec rake db:create db:migrate db:test:prepare")
  end

  desc "remove containers and setup - does not build images"
  task :reload do
    system("docker-compose stop")
    system("docker-compose rm -f")
    system("docker-compose run web bundle install")
    # system("docker-compose run web npm install")
    # system("docker-compose run web bundle exec rake assets:webpack")
    system("docker-compose run web bundle exec rake db:create db:migrate db:test:prepare")
  end
end

desc "Run the projects specs"
task :spec do
  system("docker-compose run web bundle exec rspec")
end

namespace :db do
  desc "backup from latest existing backup file (expects an existing backup file)"
  task :backup_existing do
    backup = `ls -t1 backups | head -n 1`
    system('docker-compose up -d db')

    system('docker-compose run web bundle exec rake db:drop db:create')
    system("PGPASSWORD=password psql -h localhost -U postgres -d forthepet_dev -f backups/#{backup}")
  end

  desc "backup production db excluding all images"
  task :backup do
    backup = `echo forthepet_$(date +%Y%m%d_%H%M%S).bak`

    system('docker-compose up -d db')
    system("pg_dump -v --no-owner -d forthepet -U ftp_user -h db.forthepet.com.au --exclude-table-data photos > backups/#{backup}")
    system('docker-compose run web bundle exec rake db:drop db:create')
    system("PGPASSWORD=password psql -h localhost -U postgres -d forthepet_dev -f backups/#{backup}")
  end

  desc "backup production db including images"
  task :backup_with_images do
    backup = `echo forthepet_$(date +%Y%m%d_%H%M%S).bak`

    system('docker-compose up -d db')
    system("pg_dump -v --no-owner -d forthepet -U ftp_user -h db.forthepet.com.au > backups/#{backup}")
    system('docker-compose run web bundle exec rake db:drop db:create')
    system("PGPASSWORD=password psql -h localhost -U postgres -d forthepet_dev -f backups/#{backup}")
  end
end
