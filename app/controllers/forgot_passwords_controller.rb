class ForgotPasswordsController < ApplicationController
  def new; end
  def confirm; end

  def create
    @user = User.where(email: params[:email]).first
    if @user
      AppMailer.reset_password_email(@user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = params[:email].blank? ? "Email cannot be blank" : "There is no user with this email"
      redirect_to forgot_password_path
    end
  end
end
