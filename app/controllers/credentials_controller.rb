# frozen_string_literal: true

class CredentialsController < ApplicationController
  before_action :doorkeeper_authorize!

  def set_user
    render(json: current_resource_owner)
  end
end
