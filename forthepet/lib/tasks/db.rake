namespace :db do
  desc "backup production db excluding all images"
  task backup: :environment do
    backup = `echo forthepet_$(date +%Y%m%d_%H%M%S).bak`

    system("vagrant ssh -c 'cd /forthepet && rake db:drop && rake db:create'")
    system("pg_dump -v -d forthepet -U ftp_user -h db.forthepet.com.au --exclude-table-data photos > backups/#{backup}")

    db_import_command = "sudo su - postgres -c 'cd /forthepet && psql forthepet_dev < backups/#{backup}'"
    system("vagrant ssh database -c \"#{db_import_command}\"")
  end

  desc "backup production db including images"
  task backup_with_images: :environment do
    backup = `echo forthepet_$(date +%Y%m%d_%H%M%S).bak`

    system("vagrant ssh -c 'cd /forthepet && rake db:drop && rake db:create'")
    system("pg_dump -v -d forthepet -U ftp_user -h db.forthepet.com.au > backups/#{backup}")

    db_import_command = "sudo su - postgres -c 'cd /forthepet && psql forthepet_dev < backups/#{backup}'"
    system("vagrant ssh database -c \"#{db_import_command}\"")
  end
end
