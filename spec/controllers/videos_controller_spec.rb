require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video variable for authenticated useres" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "redirects unauthenticated users to login page" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to login_path
    end
  end

  describe "POST search" do
    it "sets @videos for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      monk = Fabricate(:video, title: "Monk")
      post :search, string: 'onk'
      expect(assigns(:videos)).to eq([monk])
    end
    it "redirects to login page for unauthenticated users" do
      monk = Fabricate(:video, title: "Monk")
      post :search, string: 'onk'
      expect(response).to redirect_to login_path
    end
  end
end
