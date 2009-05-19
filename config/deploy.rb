require "eycap/recipes"
require "erb"
#############################################################
#	Servers
#############################################################

#set :user, "deploy"
set :user, "lokkedc"
set :domain, "68.233.8.4"
#set :domain, "faces.local"
server domain, :app, :web
role :db, domain, :primary => true
set :runner, :user

#############################################################
#	Application
#############################################################

set :application, "talleresdememoria"
set :keep_releases,         5
#set :deploy_to, "/var/www/#{application}"
set :home_dir, "/home/#{user}"
set :deploy_to, "#{home_dir}/apps/#{application}"
#set :dbuser,                "root"
#set :dbpass,                "root"
#set :monit_group,           "deploy"

#############################################################
#	Settings
#############################################################

# comment out if it gives you trouble. newest net/ssh needs this set.
ssh_options[:keys] = %w(/home/lokkedc/.ssh/id_rsa)
ssh_options[:paranoid] = false
default_run_options[:pty] = true
set :use_sudo, false

#############################################################
#	Git
#############################################################
set :repository,            "git@github.com:mgiorgi/tm09.git"
set :scm_username,          ""
set :scm_password,          ""
set :scm,                   :git
set :branch, "master"
#set :scm_passphrase, ""
set :deploy_via,            :remote_cache
set :repository_cache,      "#{application}_cache"
set :production_database,   "lokkedc_talleresdememoriaproduction"
set :production_dbhost,     "#{domain}"
set :staging_database,      "memoria_development"
set :staging_dbhost,        "faces.local"
set :dbuser,                "lokked_bimeleros"
set :dbpass,                "bimeleros09"
set :git_enable_submodules, 1

before "deploy:setup", :db
after "deploy", "deploy:cleanup"
after "deploy:migrations" , "deploy:cleanup"
after "deploy:update_code", "deploy:symlink_configs"
after  "deploy:update", "db:symlink"
after  "deploy:update", "applicationcontroller:symlink"
after  "deploy:update", "hostingrails:config_fcgi"
before "deploy:migrate", "applicationcontroller:symlink"
before "deploy:migrations", "applicationcontroller:symlink"

task :staging do  
  role :web, "faces.local"
  role :app, "faces.local"
  role :db , "faces.local", :primary => true
  
  set :rails_env, "staging"
  set :environment_database, defer { staging_database }
  set :environment_dbhost, defer { staging_dbhost }
end

task :production do
  role :web, "#{domain}"
  role :app, "#{domain}"
  role :db , "#{domain}", :primary => true
  
  set :rails_env, "production"
  set :environment_database, defer { production_database }
  set :environment_dbhost, defer { production_dbhost }
end

#############################################################
# ApplicationController symlink
#############################################################

namespace :applicationcontroller do
  task :symlink do
    run "ln -nfs #{deploy_to}/current/app/controllers/application_controller.rb #{deploy_to}/current/app/controllers/application.rb"
  end
end

namespace :hostingrails do
  task :config_fcgi do
    transaction do
      #run "cp  #{home_dir}/1001anecdotes/dispatch* #{deploy_to}/current/public"
      #run "cp  #{home_dir}/1001anecdotes/.htaccess #{deploy_to}/current/public"
      run "for i in `find #{deploy_to}/current/public -type d` ; do chmod g-w $i; done"
    end
  end
end

#############################################################
#	DB
#############################################################

namespace :db do
  desc "Create database yaml in shared path" 
  task :default do
    db_config = ERB.new(<<-EOF).result(binding)
    development: &defaults
      adapter: postgresql
      timeout: 5000
      database: #{staging_database}
      username: lokkedc
      password: lokked09

    test:
      <<: *defaults
      database: talleresdememoria_test

    production:
      <<: *defaults
      database: #{production_database}
    EOF

    transaction do
      run "mkdir -p #{shared_path}/config" 
      put db_config, "#{shared_path}/config/database.yml"
      run "mkdir -p #{shared_path}/public/system" 
      put db_config, "#{shared_path}/config/database.yml" 
    end
  end

  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
    run "ln -s #{shared_path}/public/system #{release_path}/public/system"
  end
end
#############################################################
#	Passenger
#############################################################
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end


namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
#after :deploy, "passenger:restart"

namespace :deploy do
  namespace :web do
    desc "Serve up a custom maintenance page."
    task :disable, :roles => :web do
      require 'erb'
      on_rollback { run "rm #{shared_path}/system/maintenance.html" }
      reason = ENV['REASON']
      deadline = ENV['UNTIL']
      set :reason, reason
      set :deadline, deadline
      template = File.read("app/views/admin/maintenance.html.erb" )
      page = ERB.new(template).result(binding)
      put page, "#{shared_path}/system/maintenance.html" ,
                :mode => 0644
    end
  end
  task :enable, :roles => :web do
    run "rm #{shared_path}/system/maintenance.html"
  end
end
