# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_memoria_session',
  :secret      => '91a89179350bb1d93664ff29e51e3f03bc1b12f234e766c40a4ca2d415fdf473057247f79fdee336de9b0e50e1508e19c62662aaf6561d09678b74d1693f4c22'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
