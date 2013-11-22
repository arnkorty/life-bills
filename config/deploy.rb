set :application, 'life_bills'
set :repo_url, 'git@bitbucket.org:arnkorty/life_bills.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, 'master'

set :deploy_to, '/var/www/life_bills/'
set :scm, :git
set :current_path, "#{deploy_to}current/"
# set :shared_path, '/var/www/life_bills/'
set :cd_current_path, "cd #{fetch(:current_path)};"
# set :format, :pretty
set :rails_env, fetch(:rails_env, 'production')
set :rvm_path, '/home/arnkorty/.rvm/bin/rvm'
set :ruby_version, '2.0.0'
set :rvm_cmd, "cd #{current_path};#{fetch(:rvm_path)} #{fetch(:ruby_version)} do "
set :bundle, "#{fetch(:rvm_cmd)} bundle "
set :bundle_cmd, "#{fetch(:rvm_cmd)} bundle exec "
set :log_level, :debug
set :pty, true

set :puma_state, "#{fetch(:current_path)}tmp/pids/puma.state"
set :puma_pid, "#{fetch(:current_path)}tmp/pids/puma.pid"
set :puma_bind, "unix://#{fetch(:current_path)}/tmp/sockets/puma.sock"
set :puma_conf, "#{fetch(:current_path)}config/puma.rb"
set :puma_role, :app
# For RVM users, it is advisable to set in your deploy.rb for now :
set :puma_cmd, "#{fetch(:bundle_cmd)}  puma -e #{fetch(:rails_env)}"
# set :pumactl_cmd, "#{fetch(:bundle_cmd)} exec  pumactl -e #{fetch(:rails_env)}"


namespace :puma do 
  desc 'Start puma'
  task :start do 
    on roles(fetch(:puma_role)) do 
      within current_path do
        if fetch(:pumactl_cmd)
          execute "#{fetch(:pumactl_cmd)} -C #{fetch(:puma_conf)}"
        else
          execute "#{fetch(:puma_cmd)} -C #{fetch(:puma_conf)}"
        end
      end
    end
  end
  %w[halt stop restart phased-restart status].each do |command|
    desc "#{command} puma"
    task command do
      on roles (fetch(:puma_role)) do
        within current_path do
          if  fetch(:pumactl_cmd)
            execute "#{fetch(:pumactl_cmd)} -S #{fetch(:puma_state)} #{command}"
          else
            execute "#{fetch(:puma_cmd)} -S #{fetch(:puma_state)} #{command}"
          end
        end
      end
    end
  end
end

# task :restart do 
#   on roles(:app) do 
#   end
# end

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do

    end
  end
  
  task :start do 
    on roles(:app), in: :sequence do       
      # execute fetch(:puma_cmd), "-C #{fetch(:puma_conf)}"
    end
  end

  task :start_and_comple_assets do 
    invoke('deploy:compile_assets')
    invoke('deploy:start')
  end
  task :mongoid_create_indexes do 
    on roles(:app), in: :sequence do
      within current_path do
        execute "RAILS_ENV=production #{fetch(:bundle_cmd)} rake db:mongoid:create_indexes"
      end
    end
  end

  task :sync_sources do 
    on roles(:app), in: :sequence do 
      within current_path do 
        # execute :scm, :pull
      end
    end
  end

  task :compile_assets do 
    on roles(:app), in: :sequence do
      within current_path do
        execute " RAILS_ENV=production #{fetch(:bundle_cmd)} rake assets:precompile"      
      end
    end
  end
  task :update_gem do 
    on (roles(:app)), in: :sequence do 
      within current_path do 
        execute "RAILS_ENV=production #{fetch(:bundle)}"
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within current_path do
        execute " RAILS_ENV=production #{fetch(:bundle_cmd)} rake cache:clear"      
      end
    end
  end

  # after :finished, 'puma:restart'
  # after :finishing, 'deploy:cleanup'
  # after "deploy:start",          "puma:start"
  # after "deploy:stop",           "puma:stop"
  # after "deploy:restart",        "puma:restart"
  # before 'deploy:start', 'deploy:update_gem'

  # after "deploy:create_symlink", "puma:after_symlink"
end
