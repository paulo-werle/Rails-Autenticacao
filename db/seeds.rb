# frozen_string_literal: true

# rubocop:disable Layout/RedundantLineBreak

# Users
::User.create!(
  name: 'Master',
  email: 'Master@master.com',
  password: '123465',
  password_confirmation: '123465'
)

# Aplications
::Doorkeeper::Application.create!(
  name: 'Admin',
  redirect_uri: 'http://localhost:3001/users/auth/doorkeeper/callback',
  confidential: false
)

# rubocop:enable Layout/RedundantLineBreak
