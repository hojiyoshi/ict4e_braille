# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ict4e_braille_session',
  :secret      => '5b3f1364fa9e70ca29811c09e3fdfcfabea531c6befbb5f0af120c8d07ad3be850f0967ec5e7093af2f2d8b01dc190b9745afdb926f6dd112c14863fdb6c62b4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
