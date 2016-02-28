namespace :db do
  desc "backup production db excluding all images"
  task :backup do
    backup = `echo forthepet_$(date +%Y%m%d_%H%M%S).bak`
    system("docker-compose run web bundle exec rake db:drop db:create")
    system("pg_dump -v -d forthepet -U ftp_user -h db.forthepet.com.au --exclude-table-data photos > backups/#{backup}")
    system("docker-compose up -d db")
    system("docker-compose run db psql -h db -U postgres forthepet_dev < backups/#{backup}")
  end

  desc "backup production db including images"
  task backup_with_images: :environment do
    backup = `echo forthepet_$(date +%Y%m%d_%H%M%S).bak`
    system("docker-compose run web bundle exec rake db:drop db:create")
    system("pg_dump -v -d forthepet -U ftp_user -h db.forthepet.com.au > backups/#{backup}")
    system("docker-compose up -d db")
    system("docker-compose run db psql -h db -U postgres forthepet_dev < backups/#{backup}")
  end
end
