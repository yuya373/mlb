# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
set :stage, :staging
set :rails_env, 'staging'
# set :branch, 'feature/capistrano'
set :branch, 'feature/unicorn'

role :app, %w{localhost}
role :web, %w{localhost}
role :db,  %w{localhost}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
# server '127.0.0.1', user: 'vagrant', roles: %w{web app db}, my_property: :my_value

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
 # set :ssh_options, {
   # keys: %w(/Users/yuya373/.vagrant.d/insecure_private_key),
   # forward_agent: true,
   # auth_methods: %w(publickey)
 # }
# and/or per server
server 'localhost',
  user:  'vagrant',
  roles: %w{web app db},
  port: 2222,
  ssh_options: {
    # user: 'user_name', # overrides user setting above
    keys: %w(/Users/yuya373/.vagrant.d/insecure_private_key ~/.ssh/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey)
    # password: 'please use keys'
  }
# setting per server overrides global ssh_options

namespace :deploy do
  desc 'Create database'
  task :create_db do
    on roles(:db) do
      execute "mysql -u root -e 'CREATE DATABASE IF NOT EXISTS #{fetch :application}_#{fetch :rails_env} ;'"
    end
  end
end
