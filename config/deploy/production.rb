############
# Server
############

set :user, "lokkedc"
set :runner, :user

set :rails_env, "production"
set :environment_database, defer { production_database }
set :environment_dbhost, defer { production_dbhost }
