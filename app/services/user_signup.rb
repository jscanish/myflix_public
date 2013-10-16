class UserSignup

  attr_reader :error_message

  def initialize(user)
    @user = user
  end

  def sign_up(stripe_token, invitation_token)
    if @user.valid?
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      charge = StripeWrapper::Charge.create(
        :amount => 999,
        :currency => "usd",
        :card => stripe_token,
        :description => "Registration charge for #{@user.email}"
        )
      if charge.successful?
        @user.save
        handle_invitation(invitation_token)
        @status = :success
        self
      else
        @status = :failed
        @error_message = charge.error_message
        self
      end
    else
      self
    end
  end

  def successful?
    @status == :success
  end

  private

  def handle_invitation(invitation_token)
    if invitation_token.present?
      invite = Invite.where(token: invitation_token).first
      @user.follow(invite.inviter)
      invite.inviter.follow(@user)
      invite.update_column(:token, nil)
    end
  end
end
