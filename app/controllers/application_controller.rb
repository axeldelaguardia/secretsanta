class ApplicationController < ActionController::Base
  def index
    if !logged_in?
      render json: {errors: "You must be logged in to view this page."}
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user
  end
end
