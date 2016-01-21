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

set :stage, :production
set :branch, 'master'
set :rails_env, 'production'

server 'forthepet.com.au', user: 'forthepet', roles: %w{all}
set :default_env, {
  FORTHEPET_DB_URL: 'postgresql://ftp_user:Bs34q345dszxvDfbbOHqweCXaaaA@db.forthepet.com.au/forthepet?pool=5',
  KEEN_PROJECT_ID: 'forthepet',
  KEEN_MASTER_KEY: '4B2727B1B16FC1D74BCDD909F3B17CF0',
  KEEN_WRITE_KEY: '7b799b9fb51a5fc79dab915e4b7076bac3abdaf61cf0dad3b7917130cc31f257fb85102464f29491ff38196835c54800eef95173978e6d673de48486ac752338b4d6dca0535ab258a341026682745d3e7a97a0ef40c35ba94428a0d925471b9be3cdd3d93cf49a14855223d7acd88ce2',
  KEEN_READ_KEY: 'f481338ecd8e41a91ed0a4e7fe3dcb12e5f1218b3c611ff68e577327288a30aa778b686c4d382a008098ceccfcba076b0a3d418b929301995ae047d0af73bb08bb2f0e4d35ea6569e7fe2ba725a5f60bec125f910c5ecdad53fc68a80895e9134687683efac43abd69d1c79e69618c92'
}
