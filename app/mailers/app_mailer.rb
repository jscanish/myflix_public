class AppMailer < ActionMailer::Base
  def welcome_email(user)
    @user = user
    mail from: "info@myflix.com", to: user.email, subject: "Welcome to Myflix!"
  end

  def reset_password_email(user)
    @user = user
    mail from: "info@myflix.com", to: user.email, subject: "Reset Password"
  end

  def invitation_email(invite, user)
    @user = user
    @invitee = invite.invitee_name
    @message = invite.message
    mail from: "info@myflix.com", to: invite.invitee_email, subject: "#{@user.full_name} wants you to join this awesome site"
  end
end
