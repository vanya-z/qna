# config valid only for current version of Capistrano
lock '3.4.0'
set :rvm_ruby_version, '2.3.0'      # Defaults to: 'default'

set :application, 'qna'
set :repo_url, 'git@github.com:vanya-z/qna.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/deployer/qna'
set :deploy_user, 'deployer'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/private_pub.yml', 'config/private_pub_thin.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', '.env')

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # execute :touch, release_path.join('tmp/restart.txt')
      invoke 'unicorn:restart'
    end
  end
end

set :thin_pid, -> { "#{current_path}/tmp/pids/thin.pid" }

namespace :private_pub do
  desc 'Start private_pub server'
  task :start do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec thin -C config/private_pub_thin.yml -d -P #{fetch(:thin_pid)} start"
        end
      end
    end
  end

  desc 'Stop private_pub server'
  task :stop do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute "if [ -f #{fetch(:thin_pid)} ] && [ -e /proc/$(cat #{fetch(:thin_pid)}) ]; then kill -9 `cat #{fetch(:thin_pid)}`; fi"
        end
      end
    end
  end

  desc 'Restart private_pub server'
  task :restart do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          stop
          start
        end
      end
    end
  end
end

after 'deploy:restart', 'private_pub:restart'