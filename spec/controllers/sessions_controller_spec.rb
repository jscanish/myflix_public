require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects to home path if logged in" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    it
  end
end
