# frozen_string_literal: true

::Rails.application.routes.draw do
  # Doorkeeper paths
  use_doorkeeper

  # Devise paths
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # Api routes
  get '/set_user', to: 'credentials#set_user'

  # Default path
  root to: 'authentications#index'
end
