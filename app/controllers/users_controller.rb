class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def new
    @user = User.new
  end

  def new_with_invite_token
    invite = Invite.where(token: params[:token]).first
    if invite
      @user = User.new(email: invite.invitee_email)
      @invite_token = invite.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      charge = Stripe::Charge.create(
        :amount => 999,
        :currency => "usd",
        :card => params[:stripeToken],
        :description => "Registration charge for #{@user.email}"
        )
      if charge.successful?
        @user.save
        handle_invitation
        session[:user_id] = @user.id
        redirect_to home_path, notice: "You registered!"
        AppMailer.delay.welcome_email(current_user)
      else
        flash[:error] = charge.error_message
        render :new
      end
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :follower_relationships, :followee_relationships)
  end

  def handle_invitation
    if params[:invite_token].present?
      invite = Invite.where(token: params[:invite_token]).first
      @user.follow(invite.inviter)
      invite.inviter.follow(@user)
      invite.update_column(:token, nil)
    end
  end
end
