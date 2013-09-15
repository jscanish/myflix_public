require 'spec_helper'

feature "user signs in" do
  background { User.create(full_name: "Josh Scanish", email: "josh@example.com", password: "josh") }
  scenario 'with existing user' do
    visit '/login'
    fill_in "Email Address", with: "josh@example.com"
    fill_in "Password", with: "josh"
    click_button "Sign in"
    page.should have_content "Josh Scanish"

    clear_email
  end
end
