set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

#################
## Git
################
set :scm_passphrase, "butia02"

set :rails_env, "staging"
set :environment_database, defer { staging_database }
set :environment_dbhost, defer { staging_dbhost }

