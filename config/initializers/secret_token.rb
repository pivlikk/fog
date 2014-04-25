# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Fog::Application.config.secret_key_base = '3d6fd563c12e9a1eaafe6fdb61cd474ad96d608efcde8940e1143b553a20057132775631a58dc7ec5359556af7c57d50d6f1971e71787dd13f6acc5de890ea11'
