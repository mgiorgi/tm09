require "eycap/recipes"
require "erb"
require 'mongrel_cluster/recipes'
set :stages, %w(staging production)
set :default_stage, 'production'
require 'capistrano/ext/multistage'
#############################################################
#	Servers
#############################################################

set :user, "lokkedc"
set :password, 'lokked09'
set :domain, "68.233.8.4"
set :runner, :user

#############################################################
#	Application
#############################################################

set :application, "talleresdememoria"
set :keep_releases,         5
set :home_dir, "/home/#{user}"
set(:deploy_to) { stage == :staging ? "/var/www/#{application}" : "#{home_dir}/apps/#{application}" }

#############################################################
#	Settings
#############################################################

# comment out if it gives you trouble. newest net/ssh needs this set.
ssh_options[:keys] = %w(/home/lokkedc/.ssh/talleresdememoria/id_rsa)
ssh_options[:paranoid] = false
default_run_options[:pty] = true
set :use_sudo, false

#############################################################
#	Git
#############################################################
set :repository,            "git://github.com/mgiorgi/tm09.git"
set :scm_username,          ""
set :scm_password,          ""
set :scm,                   :git
set(:branch) { stage == :staging ? "staging" : "master" }
set :deploy_via,            :remote_cache
set :repository_cache,      "#{application}_cache"
set :dbuser,                "lokkedc_bimeleros"
set :dbpass,                "bimeleros09"
set :git_enable_submodules, 1
set(:scm_passphrase) { stage == :staging ? "butia02" : "lokked09" }


################
# DB
###############
set :production_database,   "lokkedc_talleresdememoriaproduction"
set :production_dbhost,     "#{domain}"
set :staging_database,      "talleresdememoria_staging"
set :staging_dbhost,        "talleres.local"

task :production do
  role :web, "#{domain}"
  role :app, "#{domain}"
  role :db , "#{domain}", :primary => true
  set :stage, :produciton
end

task :staging do
  role :web, "talleres.local"
  role :app, "talleres.local"
  role :db , "talleres.local", :primary => true
  set :stage, :staging
end

before "deploy:setup", :db
after  "deploy:setup", :assets
after  "deploy:update", "db:symlink"
after  "deploy:update", "assets:symlink"
after "deploy:update", "applicationcontroller:symlink"
after "deploy:symlink", "hostingrails:config_fcgi"

namespace :assets do
  desc "Set up the assets directory in the shared dir"
  task :default do
    run "mkdir -p #{shared_path}/attachment/filename"
    run "mkdir -p #{shared_path}/group_picture/filename"
  end
  desc "Symlink the assets directory from the shared dir"
  task :symlink do
    run "rm -rf #{release_path}/public/attachment/filename"
    run "ln -nfs #{shared_path}/attachment #{release_path}/public/attachment"
    run "rm -rf #{release_path}/public/group_picture/filename"
    run "ln -nfs #{shared_path}/group_picture #{release_path}/public/group_picture"
  end
end

#############################################################
#	DB
#############################################################

namespace :db do
  desc "Create database yaml in shared path" 
  task :default do
    db_config = ERB.new(<<-EOF).result(binding)
    staging: &defaults
      adapter: postgresql
      username: postgres
      encoding: utf8
      #{ stage == :staging ? 'host: localhost' : '' }
      password: root
      timeout: 5000
      database: #{staging_database}

    test:
      <<: *defaults
      database: talleresdememoria_test

    production:
      <<: *defaults
      username: #{stage == :staging ? 'postgres' : dbuser}
      password: #{stage == :staging ? 'root' : dbpass}
      database: #{stage == :staging ? staging_database : production_database}
      encoding: utf8
      #{ stage == :staging ? 'host: localhost' : '' }
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
    #run "ln -s #{shared_path}/public/system #{release_path}/public/system"
    run "mkdir -p #{shared_path}/public/attachment/filename"
    run "ln -nfs #{shared_path}/attachment/filename #{release_path}/public/images/attachments" 
    run "mkdir -p #{shared_path}/public/group_picture/filename"
    run "ln -nfs #{shared_path}/group_picture/filename #{release_path}/public/images/group_pictures" 
  end
end

#############################################################
# ApplicationController symlink
#############################################################

namespace :applicationcontroller do
  task :symlink do
    run "ln -nfs #{release_path}/app/controllers/application_controller.rb #{release_path}/app/controllers/application.rb"
  end
end

namespace :hostingrails do
  task :config_fcgi do
    run "for i in `find #{deploy_to}/current/* -type d` ; do chmod -R g-w $i; done"
  end
end

# We do NOT want the reaper run, since that assumes we are the only FCGI
# processes on the machine and we have root access.  So, we override the
# restart task to do the proper site5 thing.
namespace :deploy do
  desc "Capfile override of the default restart task to eliminate reaper"
  task :restart, :roles => :app do
    run "pkill -9 -u #{user} -f dispatch.fcgi"
  end
  # Redefine the application server controls to use monit.
  %W(start stop restart).each do |event|
    desc "#{event} using Monit"
    task event, :except => { :no_release => true } do
      "/usr/local/bin/monit -g #{application} #{event} all"
    end
  end
end
