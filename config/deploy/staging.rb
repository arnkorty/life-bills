set :stage, :staging

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, %w{arnkorty@life_bills.arnkorty.info}
role :web, %w{arnkorty@life_bills.arnkorty.info}
role :db,  %w{arnkorty@life_bills.arnkorty.info}

set :rvm_type, :user
set :rvm_ruby_version, '2.0.0-p247'
# set :rvm_custo
# capistrano bundler
set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('bundle') }
set :bundle_flags, '--deployment --quiet'
set :bundle_without, %w{development test}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all
# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
# server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
server 'life_bills.arnkorty.info',
  user: 'arnkorty',
  roles: %w{web app},
  my_property: :my_value,
  ssh_options: {
    # user: 'user_name', # overrides user setting above
    # keys: %w(/home/user_name/.ssh/id_rsa),
    forward_agent: false,
    auth_methods: %w(password),
    password: 'fufreedom7'
  }
# setting per server overrides global ssh_options

# fetch(:default_env).merge!(rails_env: :staging)
# task :uptime do
#   on roles(:all) do |host|
#     info "Host #{host} (#{host.roles}):\t#{capture(:uptime)}"
#   end
# end