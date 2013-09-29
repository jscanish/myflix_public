require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it_behaves_like "require_logged_in_user" do
      let(:action) { get :new }
    end
    it "sets instance variable to new video" do
      user = Fabricate(:user, admin: true)
      session[:user_id] = user.id
      get :new
      expect(assigns(:video)).to be_instance_of(Video)
    end
    it "redirects regular user to root path" do
      user = Fabricate(:user, admin: false)
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to root_path
    end
  end
end
