require 'spec_helper'

describe VideosController do
  describe "GET show" do
    before do
      @video = Fabricate(:video)
      set_current_user
      get :show, id: @video.id
    end
    it "sets @video variable for authenticated users" do
      expect(assigns(:video)).to eq(@video)
    end

    it "sets @reviews variable for authenticated users" do
      review1 = Fabricate(:review, video: @video)
      review2 = Fabricate(:review, video: @video)
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it_behaves_like "require_logged_in_user" do
      let(:action) { get :show, id: @video.id }
    end
  end

  describe "POST search" do
    before do
      set_current_user
      @monk = Fabricate(:video, title: "Monk")
      post :search, string: 'onk'
    end
    it "sets @videos for authenticated users" do
      expect(assigns(:videos)).to eq([@monk])
    end
    it_behaves_like "require_logged_in_user" do
      let(:action) { post :search, string: 'onk' }
    end
  end
end
