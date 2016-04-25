[![Build Status](https://semaphoreci.com/api/v1/projects/f5a81c41-e823-496a-9d28-bdebb28110b3/426216/badge.svg)](https://semaphoreci.com/glenbray/forthepet)

forthepet
============

#A bit about the Architecture
At the moment the code is poorly designed and lacks a significant amount of specs. This will have to be addressed after the first release.

# Deployment

Currently production is setup to deploy to staging.forthepet.com.au - Running `cap production deploy` will deploy the app to digital ocean

# Database config

For this app to connect to the database the environment variables FORTHEPET_DB_DEV, FORTHEPET_DB_TEST need to be available.
eg `export FORTHEPET_DB_DEV=postgresql://devuser:abcd1234@localhost/forthepet_dev?pool=5 >> ~/.bash_profile` this command will export the environment variable postgres dev db url to your bash_profile (assuming your running mac)  you may want to change this to bashrc if running ubuntu.

# Set up with Docker
- rake docker:setup
- docker-compose up

If you would like to use data from production run `rake db:backup`

# Set up with vagrant

This setup is the exact same as production setup.

When running app in vagrant you will need to execute rake tasks, foreman, rails c, etc through the webserver vm. `vagrant ssh` defaults ssh access to webserver vm. `vagrant ssh` is equivalent to `vagrant ssh webserver`. Run `vagrant ssh database` to ssh into db server and you will have access to psql command.

1. Install vagrant and virtual box
2. `vagrant plugin install vagrant-vbguest`
3. Add the following to your bash_profile`export FORTHEPET_PROVISIONER_PATH=/path/to/forthepet-ansible` (assuming you already cloned forthepet-ansible)
4. From project root run `vagrant up` - This will spin up and provision 2 vm's (Webserver and Database server)
5. `vagant ssh` to ssh into vm (default is websever, `vagrant ssh database` for database server)
6. `foreman start` to run app in vm
7. From host computer navigate to `192.168.77.22:8080` - Optional: add the following to the bottom of /etc/hosts `192.168.77.22 forthepet.dev` This will allow you to navigate to `http://forthepet.dev:8080`
8. (Sublime text only) Ensure `atomic_save = false` for user settings
9. Other things that need setting up - mailtrap access for sending emails


The db for dev and test should have already been created and migrated. You may want to run `rake db:seed`, I wont be automating this as I think it should be optional, in the future we wont need seeds only backups of production for some data. To run rake tasks such as migrations and seeds you will need to ssh into webserver and navigate to `cd /forthepet` directory.

You will still be able to use your mac to update your code. The only difference is that you will need to `vagrant ssh` to run things. When you save code the files are auto synced with vm shared folders.

### Vagrant commands
- `vagrant up` should only be ran initially
- `vagrant suspend` suspends the machine
- `vagrant resume` resumes a suspended machine
- `vagrant halt` stops vagrant machines
- `vagrant resume` restarts a vagrant machine
- `vagrant destroy` destroys machines - You want to avoid this unless you messed up the vm's. Otherwise you need to provision the machines again which takes a while depending on speed of internet connection.

Once `vagrant up` has been run, the only commands you should be interested are - `vagrant suspend` and `vagrant resume`.

# Set up on mac (Consider using vagrant instead - setup is automated and simpler)

1. Install rbenv and ruby 2.1.5
2. Install postgres - set up users
3. bundle install (ensure bundler, rake, foreman gems are installed - gem install <gem-name>)
4. Set up postgres user (look in database.yml for username and password to setup)
5. rake db:create && rake db:migrate && rake db:seed
6. foreman start
7. Other things that need setting up - mailtrap access

#### Example env var setup for mac

Add the following to bash_profile/zshrc/bashrc `vim ~/.bash_profile`
- `export FORTHEPET_DB_DEV=postgresql://devuser:abcd1234@localhost/forthepet_dev?pool=5`
- `export FORTHEPET_DB_TEST=postgresql://devuser:abcd1234@localhost/forthepet_test?pool=5`

# Contributing

This is quite relaxed atm just to get this done. In future the below will be applied more.

1. Get access to Pivitol Tracker and work on tasks assigned.
2. To contribute create a topic branch based of an ID from a task in pivitol tracker.
3. When completed submit a pull request on the release you wish to contribute to (while still under development all pull requests are made to the branch **develop**
4. Never merge a branch without a +1 as it must go under code review first.

# Dumping production DB and restoring it in dev

* rake db:backup - downloads production db into project root
* `vagrant ssh`
* `rake db:drop && rake db:create` - no data should exist to to able to import the db
* `vagrant ssh database -c "sudo su - postgres"`
* `psql forthepet_dev < forthepet` - tab complete the database
