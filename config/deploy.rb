set :application, 'life-bills'
set :repo_url, 'git@bitbucket.org:arnkorty/life-bills.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, 'master'
set :deploy_to, '/var/www/life-bills'
set :scm, :git
set :ssh_options, { forward_agent: true }
#    forward_agent: false,
set :format, :pretty
set :log_level, :debug
set :pty, true
set :default_shell, '/bin/bash -l'
#ssh_options[:forward_agent] = true
# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 10

set :user, 'arnkorty'
set :rvm_type, :user
set :rvm_ruby_version, '2.1.0'
set :rvm_path, '~/.rvm'
set :puma_bind, -> { File.join('unix:///', 'tmp', 'life-bills_puma.sock') }
set :puma_conf, -> { "#{File.join(shared_path,'config','puma.rb')}" }
set :puma_workers, 2

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'start application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

 desc "Symlink shared resources on each release" # 配置文件
  task :symlink_shared do 
    on roles(:all), in: :sequence, wait: 5 do
      %w(mongoid.yml application.yml).each do |secure_file|
        execute "ln -nfs #{shared_path}/config/#{secure_file} #{release_path}/config/#{secure_file}"
      end
      SSHKit.config.command_map[:rvm] = "#{fetch(:rvm_path)}/bin/rvm"

      rvm_prefix = "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do"
      fetch(:rvm_map_bins).each do |command|
        SSHKit.config.command_map.prefix[command.to_sym].unshift(rvm_prefix)
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
before 'deploy:assets:precompile', 'deploy:symlink_shared'
