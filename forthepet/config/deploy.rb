# config valid only for Capistrano 3.1
lock '3.4.0'

set :application, 'forthepet'
set :deploy_to, '/var/www/forthepet'
set :repo_url, 'git@bitbucket.org:glenbray/forthepet.git'
# set :scm, :gitcopy

set :rbenv_ruby, "#{File.read('.ruby-version').chomp}"
set :rbenv_type, :system
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, %w(all)

set :assets_roles, %w(all)
set :migration_role, :all

set :delayed_job_roles, :all
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets)

set :bundle_roles, %w(all)
set :bundle_jobs, 4
set :bundle_bins, fetch(:bundle_bins, []).push('bin/delayed_job')

namespace :deploy do
  desc 'Restart your Passenger application - temporary fix'
  task :restart do
    on roles(:all) do
      execute "touch #{fetch(:deploy_to)}/current/tmp/restart.txt"
    end
  end

  after :publishing, :restart
end
