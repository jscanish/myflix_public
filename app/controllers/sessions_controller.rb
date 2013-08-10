class SessionsController < ApplicationController

  def front; end

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "You logged in!"
    else
      flash[:error] = "There's something wrong with your email or password"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You logged out!"
  end

end
