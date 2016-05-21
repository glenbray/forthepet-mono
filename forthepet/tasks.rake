namespace :docker do
  desc "setup project for development"
  task :init do
    system("docker build -t forthepet .")
    system("docker-compose build")
    system("docker-compose run web bash -c 'bundle check || bundle install'")
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
