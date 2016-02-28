namespace :docker do
  desc "setup for initial use"
  task :setup do
    system("docker-compose build")
    system("docker-compose run web bundle install")
    system("docker-compose run web bundle exec rake db:create db:schema:load")
  end
end
