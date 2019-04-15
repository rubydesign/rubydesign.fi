# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'rubydesign'
set :repo_url, 'https://github.com/rubydesign/rubydesign.fi'

set :deploy_to, '/var/www/vhosts/rubydesign.fi'

append :linked_dirs, "public/images" ,"tmp/pids", "tmp/cache"
# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/master.key')

set :passenger_restart_command, 'passenger-config restart-app'

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

end
