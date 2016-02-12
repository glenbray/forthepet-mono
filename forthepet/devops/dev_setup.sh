#!/bin/bash

sudo ufw allow 3000
sudo chown -R vagrant:vagrant /usr/local/rbenv/
ssh-keyscan github.com >> /home/vagrant/.ssh/known_hosts

sudo apt-get -y install sqlite3 libsqlite3-dev postgresql-client-9.3
gem install mailcatcher

sudo curl -sS -o /usr/local/bin/forego -O https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego
sudo chown vagrant:vagrant /usr/local/bin/forego
sudo chmod a+x /usr/local/bin/forego

gem install foreman
cd /forthepet && bundle install

echo 'Exporting DB Environment variables'
echo '=================================='

echo 'export FORTHEPET_DB_DEV=postgresql://ftp_user:Bs34q345dszxvDfbbOHqweCXaaaA@192.168.77.23/forthepet_dev?pool=5' >> /etc/profile
echo 'export FORTHEPET_DB_TEST=postgresql://ftp_user:Bs34q345dszxvDfbbOHqweCXaaaA@192.168.77.23/forthepet_test?pool=5' >> /etc/profile
echo 'export FORTHEPET_DB_PRODUCTION=postgresql://ftp_user:Bs34q345dszxvDfbbOHqweCXaaaA@192.168.77.23/forthepet?pool=5' >> /etc/profile

source /etc/profile
cd /forthepet && rake db:create

echo 'cd /forthepet' >> /home/vagrant/.bashrc
echo 'export COVERAGE=true' >> /home/vagrant/.bashrc
echo 'alias b="bundle exec"' >> /home/vagrant/.bashrc

# curl http://j.mp/spf13-vim3 -L -o - | sh
