require 'spec_helper'

feature "user resets password" do
  scenario "user resets password by following email link" do
    user = Fabricate(:user)

    visit forgot_password_path
    page.should have_content "We will send you an email with a link that you can use to "
    fill_in "email", with: user.email
    click_button "Send Email"
    page.should have_content "We have sent an email with instructions to reset your password"

  end
end
