class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "You registered!"
    else
      render :new
    end
  end

  def show

  end



private

  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end

end
