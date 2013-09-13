
def set_current_user
  @user = Fabricate(:user)
  session[:user_id] = @user.id
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def set_video
  @video = Fabricate(:video)
end

def login(a_user)
  user = a_user || Fabricate(:user)
  visit '/login'
  fill_in "Email Address", with: "#{user.email}"
  fill_in "Password", with: "#{user.password}"
  click_button "Sign in"
end

def logout(a_user)
  user = a_user
  click_on "Welcome, #{user.full_name}"
  click_on "Sign Out"
end

