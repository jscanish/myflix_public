require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets the videos for the current user" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item1 = Fabricate(:queue_item, user: user)
      queue_item2 = Fabricate(:queue_item, user: user)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
  end

  describe "POST create" do
    context "with authentication" do
      before do
        @user = Fabricate(:user)
        session[:user_id] = @user.id
        @video = Fabricate(:video)
        post :create, queue_item: Fabricate.attributes_for(:queue_item), user_id: @user.id, video_id: @video.id
      end

      it "sets @queue_item variable" do
        expect(QueueItem.first.video).to eq(@video)
      end
      it "redirects to current page" do
        expect(response).to redirect_to @video
      end
      it "associates video with current user" do
        expect(QueueItem.first.user).to eq(@user)
      end
      it "ranks videos by position" do
        video2 = Fabricate(:video)
        post :create, queue_item: Fabricate.attributes_for(:queue_item), user_id: @user.id, video_id: video2.id
        expect(@user.queue_items.map {|i| i.video.title}).to eq([@video.title, video2.title])
      end
      it "flashes success notice" do
        expect(flash[:notice]).to_not be_blank
      end
    end

    context "video is already in queue"do
      before do
        @user = Fabricate(:user)
        session[:user_id] = @user.id
        @monk = Fabricate(:video)
        Fabricate(:queue_item, video: @monk, user: @user)
        post :create, video_id: @monk.id
      end
      it "does not add video to queue again" do
        expect(@user.queue_items.count).to eq(1)
      end
      it "redirects to same page" do
        expect(response).to redirect_to(@monk)
      end
      it "flashes error message" do
        expect(flash[:notice]).to_not be_blank
      end
    end

    context "without authentication" do
      before do
        @video = Fabricate(:video)
        post :create, queue_item: Fabricate.attributes_for(:queue_item), user_id: nil, video_id: @video.id
      end
      it "redirects user to login page" do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST destroy" do
    context "authenticated users" do
      before do
        @user = Fabricate(:user)
        session[:user_id] = @user.id
        @video1 = Fabricate(:video)
        @video2 = Fabricate(:video)
        Fabricate(:queue_item, video: @video1, user: @user, position: 1)
        Fabricate(:queue_item, video: @video2, user: @user, position: 2)
        post :destroy, id: 1
      end
      it "redirects to my_queue page" do
        expect(response).to redirect_to my_queue_path
      end
      it "removes video from queue" do
        expect(@user.queue_items.count).to eq(1)
      end
      it "orders remaining videos correctly" do
        expect(@user.queue_items.first.position).to eq(1)
      end
    end



    context "unauthenticated users" do
      before do
        @video1 = Fabricate(:video)
        Fabricate(:queue_item, video: @video1, user: @user, position: 1)
        post :destroy, id: 1
      end
      it "redirects user to login page" do
        expect(response).to redirect_to login_path
      end
      it "doesn't delete the video" do
        expect(QueueItem.count).to eq(1)
      end
    end
  end
end
