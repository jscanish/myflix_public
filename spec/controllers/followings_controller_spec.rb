require 'spec_helper'

describe FollowingsController do
  before do
    @josh = Fabricate(:user, full_name: "Josh")
    @jason = Fabricate(:user, full_name: "Jason")
    @katie = Fabricate(:user, full_name: "Katie")
    session[:user_id] = @josh.id
  end
  describe "GET index" do
    it "should retrieve all follower_relationships for current user" do
    following1 = Fabricate(:following, follower_id: @josh.id, followee_id: @jason.id)
    following2 = Fabricate(:following, follower_id: @josh.id, followee_id: @katie.id)
      get :index
      expect(current_user.follower_relationships.count).to eq(2)
    end
    it_behaves_like "require_logged_in_user" do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    before do
      @following = Following.create(follower_id: @josh.id, followee_id: @katie.id)
      post :create, following: @following
    end
    it "creates a follower relationship for the current_user" do
      expect(Following.first.follower).to eq(@josh)
    end
    it "finds the proper user to follow" do
      expect(Following.first.followee).to eq(@katie)
    end
    it "redirects to people path" do
      expect(response).to redirect_to people_path
    end
    it_behaves_like "require_logged_in_user" do
      let(:action) { post :create, following: @following }
    end
  end

  describe "DELETE destroy" do
    before do
      @following1 = Fabricate(:following, id: 1, follower_id: @josh.id, followee_id: @katie.id)
      @following2 = Fabricate(:following, id: 2, follower_id: @josh.id, followee_id: @katie.id)
      delete :destroy, id: 1
    end
    it "finds the proper following" do
      expect(Following.all).to match_array([@following2])
    end
    it "destroys the following" do
      expect(Following.all.count).to eq(1)
    end
    it "redirects to people path" do
      expect(response).to redirect_to people_path
    end
    it_behaves_like "require_logged_in_user" do
      let(:action) { delete :destroy, id: 1 }
    end
  end
end
