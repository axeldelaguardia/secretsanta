require 'json'

class XmasController < ApplicationController
  layout "xmas"

  def index
    @user = UserBlueprint.render(current_user) if current_user
  end
end