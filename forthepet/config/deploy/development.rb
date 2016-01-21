# # Simple Role Syntax
# # ==================
# # Supports bulk-adding hosts to roles, the primary
# # server in each group is considered to be the first
# # unless any hosts have the primary property set.
# # Don't declare `role :all`, it's a meta role

# # Extended Server Syntax
# # ======================
# # This can be used to drop a more detailed server
# # definition into the server list. The second argument
# # something that quacks like a hash can be used to set
# # extended properties on the server.

set :stage, :production
set :branch, 'master'

APP_SERVER = '192.168.77.22'
server APP_SERVER, user: 'forthepet', roles: %w(web app db)

set :default_env, FORTHEPET_DB_URL: "postgresql://ftp_user:Bs34q345dszxvDfbbOHqweCXaaaA@192.168.77.23/forthepet_dev?pool=5"
