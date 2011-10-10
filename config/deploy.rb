$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require 'bundler/capistrano'
require 'capistrano/ext/multistage'
require 'rvm/capistrano'

default_run_options[:pty] = true
set :application, :churchapp
set :repository,  "git@github.com:nicholashibberd/churchapp.git"
set :scm, :git
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true
set :rvm_ruby_string, 'ruby-1.8.7-p352'
set :keep_releases, 5

set :rvm_type, :system

set :user, "www-data"
set :branch, "master"
set :use_sudo, false

set :deploy_to, "/var/www/#{application}"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

