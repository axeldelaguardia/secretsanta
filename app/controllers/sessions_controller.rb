class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) 
      session[:user_id] = @user.id
      render json: @user
    else
      render json: {errors: "Invalid email or password."}
    end
  end

  def destroy
    session.delete :user_id
    render json: {notice: "You have successfully logged out."}
  end

  def omniauth
    @user = User.find_or_create_by(uid: request.env['omniauth.auth']['uid'], provider: request.env['omniauth.auth']['provider']) do |u|
      u.email = request.env['omniauth.auth']['info']['email']
      u.first_name = request.env['omniauth.auth']['info']['first_name']
      u.last_name = request.env['omniauth.auth']['info']['last_name']
      u.uid = request.env['omniauth.auth']['uid']
      u.image = request.env['omniauth.auth']['info']['image']
      u.password = SecureRandom.hex(10)
    end
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render json: {errors: "Invalid email or password."}
    end
end
end
