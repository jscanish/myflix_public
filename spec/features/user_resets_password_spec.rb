require 'spec_helper'

feature "user resets password" do
  scenario "user resets password by following email link" do
    user = Fabricate(:user)
    clear_emails

    visit forgot_password_path
    fill_in "email", with: user.email
    click_button "Send Email"
    expect(page).to have_content("We have sent an email with instructions to reset your password")

    open_email(user.email)
    expect(current_email).to have_content("Reset")
    current_email.click_link("Reset my password")
    expect(page).to have_content("New Password")

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"
    expect(page).to have_content("Sign in")

    fill_in "Email Address", with: user.email
    fill_in "Password", with: "new_password"
    click_button "Sign in"
    expect(page).to have_content(user.full_name)
    clear_email
  end
end
