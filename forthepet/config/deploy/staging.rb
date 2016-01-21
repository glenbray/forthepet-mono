# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.

set :stage, :staging
set :branch, 'master'

server 'uat.forthepet.com.au', user: 'forthepet', roles: %w{all}
# set :default_env, FORTHEPET_DB_URL: 'postgresql://ftp_user:Bs34q345dszxvDfbbOHqweCXaaaA@localhost/forthepet?pool=5'
