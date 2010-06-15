# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_haikufire_session',
  :secret      => 'b87d09ff8eb150696b50b62da1349a6e8678825c613e3dd13fc93618480876e1a6e575f70544edce0d5410e3780ab3d21734b686fdb5a593316a1a53eb0c8d7a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
