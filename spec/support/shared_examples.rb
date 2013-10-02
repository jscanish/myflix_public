shared_examples "require_logged_in_user" do
  it "redirects to the login page" do
    clear_current_user
    action
    expect(response).to redirect_to login_path
  end
end

shared_examples "require admin" do
  it "redirects to root path" do
    user = Fabricate(:user, admin: false)
    session[:user_id] = user.id
    action
    expect(response).to redirect_to root_path
  end
end
