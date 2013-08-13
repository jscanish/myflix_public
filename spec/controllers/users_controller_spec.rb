require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user variable" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    it "creates the user" do
      post :create, user: {full_name: "Josh", email: "josh@example.com", password: "password"}
      expect(User.count).to eq(1)
    end
    it "starts a new session" do
      post :create, user: {full_name: "Josh", email: "josh@example.com", password: "password"}
      expect(session[:user_id]).to eq(User.first.id)
    end
    it "redirects to home path" do
      post :create, user: {full_name: "Josh", email: "josh@example.com", password: "password"}
      expect(response).to redirect_to home_path
    end
    it "does not create user when registration fails" do
      post :create, user: {full_name: "Josh", email: "josh@example.com", password: "hi"}
      expect(User.count).to eq(0)
    end
    it "renders :new template when registration fails" do
      post :create, user: {full_name: "Josh", email: "josh@example.com", password: "hi"}
      expect(response).to render_template :new
    end
    it "sets @user variable when registration fails" do
      post :create, user: {full_name: "Josh", email: "josh@example.com", password: "hi"}
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
end
