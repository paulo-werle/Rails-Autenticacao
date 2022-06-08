# frozen_string_literal: true

class AuthenticationsController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
