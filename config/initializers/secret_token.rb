# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Server::Application.config.secret_key_base = 'cca4ade865dfe33b56bc7cdedba084d51b6139361467faa8b1411256c15a5546028daec3a457e082c9dd77f35e73c46ce09244bcdeea33d01d01adef87e3ac9a'
