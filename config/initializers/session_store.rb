# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SkuleVote_session',
  :secret      => '68ecda5e7f869addf585f97a63970c583b318ec2e939f274446cae54abcbb2d505b54e9257323d0ffeb535c72d23806ef68f6db360d9da6feaa8739554d9e24c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
